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
                        "com.apps.smartx.SmartVPN.SmartT",
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
            // 示例用法
            let fileURLString = "https://hapixi.com/vpServerConfig/client.ovpn"

            Downloadx.downloadFileToDocuments(from: fileURLString) { result in
                switch result {
                case .success(let filePath):
                    print("File downloaded and saved to: \(filePath)")
                case .failure(let error):
                    print("Error downloading file: \(error)")
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
