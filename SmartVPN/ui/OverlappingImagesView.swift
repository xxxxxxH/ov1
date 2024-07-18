//
//  OverlappingImagesView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import SwiftUI

struct OverlappingImagesView: View {
    var images: [ChaterEntity]
    @State private var notificationNumber: Int = Int.random(in: 1...10)
    @State var startList = false
    
    var body: some View {
        NavigationLink(destination: ChaterListPage(), isActive: $startList) {
            ZStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Button(action: {
                        startList = true
                    }){
                        Image(images[index].avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .offset(x: CGFloat(index) * -20)
                    }
                    
                    
                }
                
                Text("\(notificationNumber)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 20, y: -10)
            }.padding(.trailing, 20)
        }
    }
}
