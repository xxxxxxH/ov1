//
//  StarListPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/2.
//

import SwiftUI

struct StarListPage: View {
    let columns = 2
    @State private var startDetails = false
    @State private var _index = 0
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<numberOfRows(), id: \.self) { rowIndex in
                        HStack(spacing: 10) {
                            ForEach(0..<columns, id: \.self) { columnIndex in
                                let index = rowIndex * columns + columnIndex
                                if index < Dev.starList.count {
                                    StarButton(item: Dev.starList[index]){
                                        startDetails = true
                                        _index = index
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                
                NavigationLink(destination: StarDetailsPage(starEntity: Dev.starList[_index]), isActive: $startDetails){EmptyView()}
            }
        }
        
    }
    
    private func numberOfRows() -> Int {
        return (Dev.starList.count + columns - 1) / columns // 向上取整
    }
}

struct StarButton: View {
    let item: StarEntity
    
    let itemClick:()->Void
    
    var body: some View {
        Button(action: {
            itemClick()
        }) {
            HStack {
                Image(item.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Text(item.name).bold().font(.system(size: 16))
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .foregroundColor(.white)
            .background(Color(hex: item.color).opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(height: 100)
    }
}


