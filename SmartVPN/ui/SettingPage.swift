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
    @State private var startPrivacy = false
    var body: some View {
        
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            VStack{
                ForEach(Dev.sList){item in
                    SettingItem(itemData: item, update: {
                        toastMessage = "Already the latest version"
                        showToast = true
                    }, privacy: {
                        startPrivacy = true
                    })
                }
                
                NavigationLink(destination: PrivacyPage(), isActive: $startPrivacy){
                    EmptyView()
                }
                
                HStack{
                    Text("Contact us").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).padding(.top, 20).padding(.horizontal,20)
                    Spacer()
                }
                
                Button(action: {
                    UIPasteboard.general.string = "14398441@qq.com"
                    showToast = true
                    toastMessage = "Mailbox copied"
                }, label: {
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 0.6)
                        HStack{
                            Image("ic_contact").padding()
                            Text(attributedString("14398441@qq.com"))
                                .foregroundColor(.white)
                                .textSelection(.disabled)
                            Spacer()
                            Image("ic_arrow_right")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding()
                        }
                    }.frame(height: 50).padding(.horizontal, 20)
                })
                
                Spacer()
            }
            
            if showToast{
                ToastView(message: toastMessage, isShowing: $showToast)
            }
            
        }.background(.clear)
    }
    
    func attributedString(_ email: String) -> AttributedString {
            var attributedString = AttributedString(email)
            attributedString.link = nil
            return attributedString
        }
}

