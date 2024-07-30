//
//  Config.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import Foundation
import TunnelKitCore
import TunnelKitManager
import TunnelKitOpenVPN
class Config{
    
    static func makeConfig() -> OpenVPN.ProviderConfiguration?{
        print("config_path = \(Downloadx.config_path)")
        var path: String = ""
        if #available(iOS 16.0, *) {
            path = Downloadx.config_path
        } else {
            path = Downloadx.config_path
        }
        guard FileManager.default.fileExists(atPath: path) else {
            //earthAction()
            return nil
        }
        guard
            let builder = try? OpenVPN.ConfigurationParser.parsed(fromURL: Downloadx.config_url!)
        else {
            print("VPN Connection Failed! Please Try Again.")
            return nil
        }
        let cfg = builder.configuration

        var providerConfiguration = OpenVPN.ProviderConfiguration("SmartX VPN", appGroup: "group.com.apps.smartx.SmartVPN", configuration: cfg)
        providerConfiguration.shouldDebug = true
        providerConfiguration.masksPrivateData = false
        return providerConfiguration
    }
}
