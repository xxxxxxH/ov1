//
//  ImageGridView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/9.
//

import SwiftUI

struct ImageGridView2: View {
    let images: [String]

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 2
            let height = geometry.size.height / 2
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(images[0])
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                    
                    Image(images[1])
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                }
                
                HStack(spacing: 0) {
                    Image(images[2])
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                    
                    Image(images[3])
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                }
            }.cornerRadius(10)
        }
    }
}
