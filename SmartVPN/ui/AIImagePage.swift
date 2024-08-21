//
//  AIImagePage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/20.
//

import SwiftUI

struct AIImagePage: View {
    let imageCode:String
    let width:CGFloat
    let height:CGFloat
    @State private var showLoading = false
    @State private var showToast = false
    @State private var toastStr = ""
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            Base64ImageView(base64String: imageCode, width: width, height: height)
            
            VStack{
                Spacer()
                
                Button(action: {
                    showLoading = true
                    ImageSaver().saveImage(base64String: imageCode, result: {result in
                        toastStr = result == true ? "save success" : "save failed"
                        showToast = true
                        showLoading = false
                    })
                }, label: {
                    Text("Download")
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .frame(width: UIScreen.main.bounds.width - 40,height: 60)
                        .font(.system(size: 16, weight: .bold))
                }).background(Color.chatButton)
                    .cornerRadius(10)
            }.padding()
            
            if showLoading{
                LoadingView(text: "Saving,please wait...")
            }
            
            if showToast{
                ToastView(message: toastStr, isShowing: $showToast)
            }
        }
    }
}

