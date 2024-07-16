//
//  NotificationBubbleView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import Foundation
import SwiftUI
struct NotificationBubbleView: View {
    let number: Int
    
    var body: some View {
        Text("\(number)")
            .font(.caption)
            .foregroundColor(.white)
            .padding(6)
            .background(Color.red)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 0)
            )
            .offset(x: 10, y: -10) // Adjust position as needed
    }
}
