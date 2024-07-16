//
//  SettingPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/15.
//

import SwiftUI

struct SettingPage: View {
    
    @State private var showToast = false
    @State private var toastMessage = "Already the latest version"
    var body: some View {
        
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            VStack{
                ForEach(Dev.sList){item in
                    SettingItem(itemData: item){
                        showToast = true
                    }
                }
                Spacer()
            }
            
            if showToast{
                ToastView(message: toastMessage, isShowing: $showToast)
            }
            
        }.background(.clear)
    }
}

