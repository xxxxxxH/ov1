//
//  PacketTunnelProvider.swift
//  SmartT
//
//  Created by xxxxxxh on 2024/7/11.
//

import NetworkExtension
import TunnelKitOpenVPNAppExtension

class PacketTunnelProvider: OpenVPNTunnelProvider {
    override func startTunnel(options: [String: NSObject]? = nil) async throws {
        dataCountInterval = 3
        try await super.startTunnel(options: options)
    }
}
