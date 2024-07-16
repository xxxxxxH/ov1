//
//  ContentView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import SwiftUI
import TunnelKitManager
import NetworkExtension
import TunnelKit

struct ContentView: View {
    private let vpn = NetworkExtensionVPN()
    @StateObject private var vpnStatusManager = VPNStatusManager()
    
    var body: some View {
        VStack {
            Button("connect", action: {
                guard let cfg = Config.makeConfig() else { return }
                Task {
                    let extra = NetworkExtensionExtra()
                    try await vpn.reconnect(
                        Dev.extPkg,
                        configuration: cfg,
                        extra: extra,
                        after: .seconds(2)
                    )
                }
            }).padding()
            
            Button("disconnect", action: {
                Task {
                    await vpn.disconnect()
                }
            }).padding()
            
            Text("VPN Status: \(vpnStatusManager.statusDescription(for: vpnStatusManager.vpnStatus))")
                            .padding()
        }.onAppear(){

            //Downloadx.downloadFileToDocuments(from: Dev.nodeInfo!.hotUrl)
        }
    }
    
}

