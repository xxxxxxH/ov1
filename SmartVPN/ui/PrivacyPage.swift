//
//  PrivacyPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/17.
//

import SwiftUI
import WebKit

struct PrivacyPage : UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let req = URLRequest(url: URL(string: "https://aichatboxonline.top/privacy.html")!)
        uiView.load(req)
    }
}
