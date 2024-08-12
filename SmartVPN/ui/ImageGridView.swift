//
//  ImageGridView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/9.
//

import SwiftUI

struct ImageGridView: View {
    let images: [ChaterEntity]

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 2
            let height = geometry.size.height / 2
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(images[0].hBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                    
                    Image(images[1].hBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                }
                
                HStack(spacing: 0) {
                    Image(images[2].hBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                    
                    Image(images[3].hBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                }
            }.cornerRadius(10)
        }
    }
}
