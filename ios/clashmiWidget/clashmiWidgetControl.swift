//
//  clashmiWidgetControl.swift
//  clashmiWidget
//
//  Created by user on 2026/1/19.
//

import AppIntents
import SwiftUI
import WidgetKit

import NetworkExtension

struct clashmiWidgetControl: ControlWidget {
    public static let controlKind: String = "com.nebula.clashmi.clashmiWidget.ControlCenterToggle"
    private static let bundleIdentifier = "com.nebula.clashmi.clashmiService"
    private static let groupIdentifier = "group.com.nebula.clashmi"
    private static let defaultSharedDirectory: URL! = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)!
    public static let configFile = defaultSharedDirectory.appendingPathComponent("service.json", isDirectory: false)
    public init(){
        VpnServiceHandler.shared.controlKind = clashmiWidgetControl.controlKind
        VpnServiceHandler.shared.bundleIdentifier = clashmiWidgetControl.bundleIdentifier
        VpnServiceHandler.shared.configFilePath = clashmiWidgetControl.configFile.path()
        VpnServiceHandler.shared.uiServerAddress = "Clash Mi"
        VpnServiceHandler.shared.uiLocalizedDescription = "Clash Mi"
        VpnServiceHandler.shared.getState(result: {_ in })
    }

    static func setOnDemandEnabled(_ enabled: Bool) async throws {
        let managers = try await NETunnelProviderManager.loadAllFromPreferences()
        guard let manager = managers.first(where: { manager in
            let tunnelProtocol = manager.protocolConfiguration as? NETunnelProviderProtocol
            return tunnelProtocol?.providerBundleIdentifier == bundleIdentifier
        }) else {
            return
        }

        if enabled {
            let rule = NEOnDemandRuleConnect()
            rule.interfaceTypeMatch = .any
            manager.onDemandRules = [rule]
        } else {
            manager.onDemandRules = nil
        }
        manager.isOnDemandEnabled = enabled
        try await manager.saveToPreferences()
    }

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: Self.controlKind,
            provider: Provider()
        ) { value in
             ControlWidgetToggle(
                "Clash Mi",
                isOn: value,
                action: StartVPNServiceIntent()
            ) { isRunning in
                Label(isRunning ? "ON" : "OFF", image: "control_widget")
            }
        }
        .displayName("ON/OFF")
        .description("Start or Stop Clash Mi VPN service")
    }
}

extension clashmiWidgetControl {
    struct Provider: ControlValueProvider {
         var previewValue: Bool {
            false
        }

        func currentValue() async throws -> Bool {
            let runing = await isRunning()
            return runing
        }

        func isRunning() async -> Bool {
            let status = await VpnServiceHandler.shared.getCurrentState()
            return status == NEVPNStatus.connecting || status == NEVPNStatus.connected || status == NEVPNStatus.reasserting
        }
    }
}

struct StartVPNServiceIntent: SetValueIntent {
    static let title: LocalizedStringResource = "ON/OFF"

    @Parameter(title: "ON")
    var value: Bool

    func perform() async throws -> some IntentResult {
        if await FileManager.default.fileExists(atPath: clashmiWidgetControl.configFile.path()) {
            if value {
                let started = await withCheckedContinuation { continuation in
                    VpnServiceHandler.shared.start(timeoutInSeconds: 30) { err in
                        continuation.resume(returning: err == nil)
                    }
                }
                if started {
                    try? await clashmiWidgetControl.setOnDemandEnabled(true)
                }
            } else {
                try? await clashmiWidgetControl.setOnDemandEnabled(false)
                await withCheckedContinuation { continuation in
                    VpnServiceHandler.shared.stop { _ in
                        continuation.resume()
                    }
                }
            }
        }
        
        return .result()
    }
}
