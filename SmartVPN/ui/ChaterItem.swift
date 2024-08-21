//
//  ChaterItem.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/12.
//

import SwiftUI

struct ChaterRowView: View {
    let chater: ChaterEntity
    
    
    var body: some View {
      
            HStack(spacing: 10) {
                Image(chater.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(chater.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(chater.introduce)
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                NotificationBubbleView(number: 1)
            }  .padding(10)
                .background(.clear)
                .cornerRadius(10)
       
        
    }
}
