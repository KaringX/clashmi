import Darwin
import FlutterMacOS
import Foundation
import NetworkExtension

/// The root system extension cannot share the GUI user's App Group container.
/// The host has a sandbox exception for this directory only (see Runner.entitlements).
enum ProfileStorage {
    private static let providerIdentifier = "com.nebula.clashmi.clashmiServiceSE"

    static func register(with messenger: FlutterBinaryMessenger) -> FlutterMethodChannel {
        let channel = FlutterMethodChannel(name: "com.nebula.clashmi/profile-storage", binaryMessenger: messenger)
        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "directory":
                do {
                    result(try directory().path)
                } catch {
                    result(flutterError(error))
                }
            case "updateTunnelConfiguration":
                Task { @MainActor in
                    do {
                        result(try await updateTunnelConfiguration())
                    } catch {
                        result(flutterError(error))
                    }
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        return channel
    }

    private static func flutterError(_ error: Error) -> FlutterError {
        let error = error as NSError
        return FlutterError(code: "ProfileStorage", message: error.localizedDescription,
                            details: ["domain": error.domain, "code": error.code])
    }

    private static func failure(_ message: String) -> NSError {
        NSError(domain: "ProfileStorage", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }

    private static func userHome() throws -> URL {
        // Foundation's home/Application Support APIs and HOME can be redirected
        // into the sandbox. Resolve the GUI user's home, never root's home.
        var size = max(Int(sysconf(_SC_GETPW_R_SIZE_MAX)), 16_384)
        while size <= 1_048_576 {
            var entry = passwd()
            var resolved: UnsafeMutablePointer<passwd>?
            var buffer = [CChar](repeating: 0, count: size)
            var home: String?
            let status = buffer.withUnsafeMutableBufferPointer { pointer -> Int32 in
                let status = getpwuid_r(getuid(), &entry, pointer.baseAddress, pointer.count, &resolved)
                if status == 0, resolved != nil, let path = entry.pw_dir {
                    home = String(cString: path)
                }
                return status
            }
            if status == ERANGE {
                size *= 2
                continue
            }
            guard status == 0, let home, home.hasPrefix("/"), home != "/" else {
                throw failure("Unable to resolve the user's home directory (getpwuid_r: \(status)).")
            }
            return URL(fileURLWithPath: home, isDirectory: true)
        }
        throw failure("Unable to resolve the user's home directory: passwd entry is too large.")
    }

    private static func directory() throws -> URL {
        let url = try userHome().appendingPathComponent("Library/Application Support/com.nebula.clashmi", isDirectory: true)
        let manager = FileManager.default
        // Reject a symlink or a directory owned by another account instead of
        // accidentally sharing/writing data outside the one allowed directory.
        if !manager.fileExists(atPath: url.path) {
            try manager.createDirectory(at: url, withIntermediateDirectories: true,
                                        attributes: [.posixPermissions: 0o700])
        }
        let attributes = try manager.attributesOfItem(atPath: url.path)
        guard attributes[.type] as? FileAttributeType == .typeDirectory,
              (attributes[.ownerAccountID] as? NSNumber)?.uint32Value == getuid() else {
            throw failure("Clash Mi's data directory must be a directory owned by the current user.")
        }
        try manager.setAttributes([.posixPermissions: 0o700], ofItemAtPath: url.path)
        return url
    }

    @MainActor
    private static func updateTunnelConfiguration() async throws -> Bool {
        let file = try directory().appendingPathComponent("data/service.json")
        guard FileManager.default.isReadableFile(atPath: file.path) else {
            throw failure("The prepared VPN configuration is not readable: \(file.path)")
        }
        // Existing VPN preferences survive an app upgrade. Update their old
        // App Group path too, so system/on-demand starts use the new location.
        var stoppedTunnel = false
        for manager in try await NETunnelProviderManager.loadAllFromPreferences() {
            guard let configuration = manager.protocolConfiguration as? NETunnelProviderProtocol,
                  configuration.providerBundleIdentifier == providerIdentifier else {
                continue
            }
            var values = configuration.providerConfiguration ?? [:]
            if values["configFilePath"] as? String == file.path {
                continue
            }
            // A running provider retains its old protocolConfiguration even
            // after preferences change. A hot core reload would reread the old
            // file, so disconnect it before publishing the new preference.
            // The Dart lifecycle restores the configured on-demand policy
            // after successfully starting the tunnel again.
            if manager.isOnDemandEnabled {
                manager.isOnDemandEnabled = false
                try await manager.saveToPreferences()
            }
            if manager.connection.status != .disconnected && manager.connection.status != .invalid {
                manager.connection.stopVPNTunnel()
                let deadline = Date().addingTimeInterval(15)
                while manager.connection.status != .disconnected && manager.connection.status != .invalid {
                    guard Date() < deadline else {
                        throw failure("Timed out disconnecting the VPN for profile storage migration.")
                    }
                    try await Task.sleep(nanoseconds: 100_000_000)
                }
                stoppedTunnel = true
            }
            values["configFilePath"] = file.path
            configuration.providerConfiguration = values
            manager.protocolConfiguration = configuration
            try await manager.saveToPreferences()
        }
        return stoppedTunnel
    }
}
