//
//  ContentView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/10.
//

import SwiftUI
import TunnelKitManager

struct ContentView: View {
    private let vpn = NetworkExtensionVPN()
    var body: some View {
        VStack {
            Button("connect", action: {
                guard let cfg = Config.makeConfig() else { return }
                Task {
                    let extra = NetworkExtensionExtra()
                    print("cfg = \(cfg)")
                    print("extra = \(extra)")
                    try await vpn.reconnect(
                        "com.apps.smartx.SmartVPN.SmartT",
                        configuration: cfg,
                        extra: extra,
                        after: .seconds(2)
                    )
                }
            })
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
