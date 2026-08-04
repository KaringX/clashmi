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
            await withCheckedContinuation { continuation in
                if value {
                    VpnServiceHandler.shared.start(timeoutInSeconds: 30) { err in
                        continuation.resume(returning: err == nil)
                    }
                } else {
                    VpnServiceHandler.shared.stop { err in
                         continuation.resume(returning: err == nil)
                    }
                }
            }
        }
        
        return .result()
    }
}
