//
//  MarqueeView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/2.
//

import SwiftUI

struct MarqueeView: View {
    let text: String
    let duration: Double
    let fontSize: CGFloat
    let textColor: Color
    let backgroundColor: Color

    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            Text(text)
                .font(.system(size: fontSize))
                .foregroundColor(textColor)
                .padding(.leading, geometry.size.width)
                .background(backgroundColor)
                .offset(x: offset)
                .onAppear {
                    let textWidth = geometry.size.width + text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
                    withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                        offset = -textWidth
                    }
                }
        }
        .frame(height: fontSize)
    }
}
