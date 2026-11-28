import Foundation
import System
import Libclash

import NetworkExtension

#if os(iOS)
import WidgetKit
#endif
// #if os(iOS)
// import UIKit
// #elseif os(macOS)
// import AppKit
// #endif

public class VpnServiceConfig: Codable {
    var base_dir: String = ""
    var work_dir: String = ""
    var cache_dir: String = ""
    var core_path: String = ""
    var log_path: String = ""
    var err_path: String = ""
    var id: String = ""
    var version: String = ""
    var name: String = ""
    var include_all_networks = false 
    var exclude_local_networks = false 
    var exclude_cellular_services = false 
    var exclude_apns = false 
    var exclude_device_communication = false
    var enforce_routes = false 
    var auto_route_use_sub_ranges_by_default = false
    var core_path_patch: String = ""
    var core_path_patch_final: String = ""

    enum CodingKeys: String, CodingKey {
        case base_dir
        case work_dir
        case cache_dir
        case core_path
        case log_path
        case err_path
        case id
        case version
        case name
        case include_all_networks  
        case exclude_local_networks 
        case exclude_cellular_services 
        case exclude_apns 
        case exclude_device_communication
        case enforce_routes  
        case auto_route_use_sub_ranges_by_default
        case core_path_patch
        case core_path_patch_final
    }

    init() {}

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        base_dir = try container.decodeIfPresent(String.self, forKey: .base_dir) ?? ""
        work_dir = try container.decodeIfPresent(String.self, forKey: .work_dir) ?? ""
        cache_dir = try container.decodeIfPresent(String.self, forKey: .cache_dir) ?? ""
        core_path = try container.decodeIfPresent(String.self, forKey: .core_path) ?? ""
        log_path = try container.decodeIfPresent(String.self, forKey: .log_path) ?? ""
        err_path = try container.decodeIfPresent(String.self, forKey: .err_path) ?? ""
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        version = try container.decodeIfPresent(String.self, forKey: .version) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        include_all_networks = try container.decodeIfPresent(Bool.self, forKey: .include_all_networks) ?? false
        exclude_local_networks = try container.decodeIfPresent(Bool.self, forKey: .exclude_local_networks) ?? false
        exclude_cellular_services = try container.decodeIfPresent(Bool.self, forKey: .exclude_cellular_services) ?? false
        exclude_apns  = try container.decodeIfPresent(Bool.self, forKey: .exclude_apns) ?? false
        exclude_device_communication = try container.decodeIfPresent(Bool.self, forKey: .exclude_device_communication) ?? false
        enforce_routes  = try container.decodeIfPresent(Bool.self, forKey: .enforce_routes) ?? false
        auto_route_use_sub_ranges_by_default = try container.decodeIfPresent(Bool.self, forKey: .auto_route_use_sub_ranges_by_default) ?? false
        core_path_patch = try container.decodeIfPresent(String.self, forKey: .core_path_patch) ?? ""
        core_path_patch_final = try container.decodeIfPresent(String.self, forKey: .core_path_patch_final) ?? ""
    }
}

struct ProviderMessage: Codable {
    var messageId: String = ""
    var messageParams: String = ""
}

struct ProviderMessageResponse: Codable {
    var err: String?
    var data: String? 
    var extra: [String: String] = [:]
}

enum VpnError: Error {
    case Error(String)
}

open class ExtensionProvider: NEPacketTunnelProvider {
    private static let systemExtension = true
    private static let controlKind = "com.nebula.clashmi.clashmiWidget.ControlCenterToggle"
    public var config: VpnServiceConfig?

    override open func startTunnel(
        options: [String: NSObject]?
    ) async throws {
        // if options != nil && options!["fromApp"] is NSString {
        //
        // }
        
        do {
            try await start()
        }
        catch let VpnError.Error(err) {
            Task.detached {
                try? await Task.sleep(nanoseconds: NSEC_PER_MSEC * 100)
                exit(EXIT_FAILURE)
            }
            throw NSError(domain: "VpnError:\(err),", code: 0)
        }
        catch let err {
            Task.detached {
                try? await Task.sleep(nanoseconds: NSEC_PER_MSEC * 100)
                exit(EXIT_FAILURE)
            }
            throw err
        }
        handleVPNStatusChanged()

    }

    override open func stopTunnel(
        with reason: NEProviderStopReason, completionHandler: @escaping () -> Void
    ) {
        handleVPNStatusChanged()
        completionHandler() // completionHandler faster than syn
        exit(EXIT_FAILURE)
    }

    override open func handleAppMessage(_ messageData: Data) async -> Data? {
        var messageResponse = ProviderMessageResponse()
        do {
            let message = try! JSONDecoder().decode(ProviderMessage.self, from: messageData)
            if message.messageId == "restart" {
                try await restartService(extra: &messageResponse.extra)
            } else if message.messageId == "clashiApiConnections"{
                let content = LibclashGetConnections(message.messageParams == "true")
                let data: Data = content.data(using: String.Encoding.utf8)!
                return data
            } else if message.messageId == "clashiApiTraffic"{
                let content = LibclashGetTraffic()
                let data: Data = content.data(using: String.Encoding.utf8)!
                return data
            } else {
                messageResponse.err = "unsupport \(message.messageId)"
            }
        }
        catch let VpnError.Error(err) {
            messageResponse.err = err
        }
        catch let err {
            messageResponse.err = err.localizedDescription
        }
#if os(iOS)
        if #available(iOS 18.0, *) {
           ControlCenter.shared.reloadControls(ofKind: ExtensionProvider.controlKind)
        }
#endif
        if messageResponse.err != nil {
            let body: Data = try! JSONEncoder().encode(messageResponse)
            DispatchQueue.global().async {
                exit(EXIT_FAILURE)
            }
            return body
        }

        return nil
    }

    override open func sleep(completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    override open func wake() {
    }
}

extension ExtensionProvider {
    fileprivate func setupService() async throws {
        guard let tunnelProtocol = protocolConfiguration as? NETunnelProviderProtocol,
              let conf = tunnelProtocol.providerConfiguration,
              let configFilePath = conf["configFilePath"] as? String,
              !configFilePath.isEmpty
        else {
            throw VpnError.Error("providerConfiguration invalid")
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: configFilePath))
            config = try JSONDecoder().decode(VpnServiceConfig.self, from: jsonData)
        } catch {
            // A missing/malformed file is not evidence that Full Disk Access is
            // needed. Preserve the actual failure instead of crashing with try!.
            let underlying = error as NSError
            throw NSError(domain: "VpnServiceConfiguration", code: underlying.code, userInfo: [
                NSLocalizedDescriptionKey: "Unable to load VPN configuration: \(underlying.localizedDescription)",
                NSUnderlyingErrorKey: underlying,
                NSFilePathErrorKey: configFilePath,
            ])
        }
        let setupOptions = LibclashSetupOptions()
        setupOptions.homeDir = config!.base_dir
        setupOptions.logFile = config!.log_path
        setupOptions.errorFile = config!.err_path

        var error: NSError?
        LibclashSetup(setupOptions, &error)
        if error != nil {
            throw VpnError.Error("LibclashSetup failed: \(error!.localizedDescription)")
        }
    }

    fileprivate func writeError(_ message: String) {
        NSLog(message)
        if config != nil && !config!.err_path.isEmpty {
            do {
                let fileUrl = URL(fileURLWithPath: config!.err_path)
                try message.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
            } catch {
            }
        }
    }

    fileprivate func start() async throws {
        try await setupService()
        try await startService()
    }

    fileprivate func startService() async throws {
        let startOptions = LibclashStartOptions()
        startOptions.configFile = config!.core_path
        startOptions.configFilePatch = config!.core_path_patch
        startOptions.configFilePatchFinal = config!.core_path_patch_final

        let tunInterface = ExtensionPlatformInterface(self)
        var error: NSError?
        LibclashStart(startOptions, tunInterface, &error)
        if error != nil {
            throw VpnError.Error("LibclashStart failed: \(error!.localizedDescription)")
        }
    }

    fileprivate func stopService() async throws {
        var error: NSError?
        LibclashStop(&error)
    }

    func restartService(extra: inout [String: String]) async throws {
        if reasserting {
            extra["is_close_error"] = "true"
            throw VpnError.Error("reasserting")
        }
        reasserting = true
        defer {
            reasserting = false
        }
        do {
            try await stopService()
        }
        catch let err {
            extra["is_close_error"] = "true"
            throw err
        }
        try await setupService()
        try await startService()
    }

    func postServiceClose() {
    }
    func handleVPNStatusChanged() {
#if os(iOS)
        if #available(iOS 18.0, *) {
            ControlCenter.shared.reloadControls(ofKind: ExtensionProvider.controlKind)
            CFNotificationCenterPostNotification(
                CFNotificationCenterGetDarwinNotifyCenter(),
                CFNotificationName("com.nebula.clashmi.vpn.statusChanged" as CFString),
                nil,
                nil,
                true
            )
        }
#endif
    }
}
