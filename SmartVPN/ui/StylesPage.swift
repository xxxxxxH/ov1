//
//  StylesPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/20.
//

import SwiftUI

struct StylesPage: View {
    let columns = 3
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<numberOfRows(), id: \.self) { rowIndex in
                        HStack(spacing: 10) {
                            ForEach(0..<columns, id: \.self) { columnIndex in
                                let index = rowIndex * columns + columnIndex
                                if index < Dev.styles.count {
                                    StyleItem(item: Dev.styles[index], itemClick: {
                                        Dev.currentStyle = Dev.styles[index]
                                        presentationMode.wrappedValue.dismiss()
                                    })
                                }else{
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding()
                
            }
        }
        
    }
    
    private func numberOfRows() -> Int {
        return (Dev.styles.count + columns - 1) / columns // 向上取整
    }
}

struct StyleItem: View {
    let item: AiImageEntity
    
    let itemClick:()->Void
    
    var body: some View {
        Button(action: {
            itemClick()
        }, label: {
            ZStack{
                Image(item.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width - 60) / 3,height: (UIScreen.main.bounds.width - 60) / 3)
                VStack{
                    Spacer()
                    Text(item.type).foregroundColor(.white).frame(width: (UIScreen.main.bounds.width - 60) / 3, height: 20).background(.black.opacity(0.5)).font(.system(size: 12))
                }
            }
            
        }).cornerRadius(10)
    }
}

