//
//  ChatBubble.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import SwiftUI

struct ChatBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isSentByUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color(hex: "#20bf6b").opacity(0.8))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            } else {
                if message.isLoading {
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                        Spacer()
                    }
                } else {
                    Text(message.text)
                        .padding()
                        .background(Color(hex: "#f3a683").opacity(0.8))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
}
