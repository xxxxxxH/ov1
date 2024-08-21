//
//  Base64ImageView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/19.
//

import SwiftUI

struct Base64ImageView: View {
    let base64String: String
    let width:CGFloat
    let height:CGFloat
    
    var body: some View {
        if let imageData = Data(base64Encoded: base64String),
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: width, height: height)
        }
    }
}

