//
//  LoadingView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/31.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            // 半透明背景
            Color.black.opacity(0.8)
            
            // 中心的加载指示器
            VStack {
                ProgressView("Scaning...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white)).foregroundColor(.white).scaleEffect(1.5)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoadingView()
}
