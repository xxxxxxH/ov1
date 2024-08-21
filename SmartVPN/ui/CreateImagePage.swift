//
//  CreateImagePage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/19.
//

import SwiftUI

struct CreateImagePage: View {
    @State private var imageCode = ""
    @State private var descpirtion = ""
    @State private var showLoading = false
    @State private var showToast = false
    @State private var style = "random"
    @State private var model = "random"
    @State private var size = "1:1"
    @State private var startImage = false
    @State private var width:CGFloat = 0
    @State private var height:CGFloat = 0
    @State private var startStyles = false
    @State private var startModels = false
    
    var body: some View {
        ZStack{
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack{
                    //描述
                    VStack{
                        HStack{
                            Text("Descpirtion").foregroundColor(.white).bold()
                            Spacer()
                        }
                        
                        TextEditor(text: $descpirtion)
                            .frame(height: 120)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                    }
                    Spacer().frame(height: 20)
                    //推荐描述
                    VStack{
                        HStack{
                            Text("Try it this:").foregroundColor(.white).bold()
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10){
                                ForEach(0..<Dev.recommends.count){index in
                                    let desc = Dev.recommends[index]
                                    Button(desc, action: {descpirtion = desc})
                                }
                                
                            }
                        }
                        
                    }
                    Spacer().frame(height: 20)
                    //style
                    VStack{
                        HStack{
                            Text("Style：\(style)").foregroundColor(.white).bold()
                            Spacer()
                        }
                        HStack(spacing: 10){
                            ForEach(0..<2){index in
                                Button(action: {
                                    Dev.currentStyle = Dev.styles[index]
                                    style = Dev.styles[index].type
                                }, label: {
                                    ZStack{
                                        Image(Dev.styles[index].icon)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (UIScreen.main.bounds.width - 60) / 3,height: (UIScreen.main.bounds.width - 60) / 3)
                                        VStack{
                                            Spacer()
                                            Text(Dev.styles[index].type).foregroundColor(.white).frame(width: (UIScreen.main.bounds.width - 60) / 3, height: 20).background(.black.opacity(0.5)).font(.system(size: 12))
                                        }
                                    }
                                    
                                }).cornerRadius(10)
                            }
                            
                            Button(action: {
                                startStyles = true
                            }, label: {
                                ZStack{
                                    Image(Dev.styles[2].icon)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (UIScreen.main.bounds.width - 60) / 3,height: (UIScreen.main.bounds.width - 60) / 3)
                                    
                                    Text("More").frame(width: (UIScreen.main.bounds.width - 60) / 3,height: (UIScreen.main.bounds.width - 60) / 3)
                                        .foregroundColor(.white)
                                        .background(.black.opacity(0.5))
                                    
                                    
                                }
                                
                            }).cornerRadius(10)
                            
                        }
                    }
                    Spacer().frame(height: 20)
                    //model
                    VStack{
                        HStack{
                            Text("Model：\(model)").foregroundColor(.white).bold()
                            Spacer()
                        }
                        HStack(spacing: 10){
                            ForEach(0..<2){index in
                                Button(action: {
                                    Dev.currentModel = Dev.models[index]
                                    model = Dev.models[index].type
                                }, label: {
                                    ZStack{
                                        Image(Dev.models[index].icon)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (UIScreen.main.bounds.width - 60) / 3,height: (UIScreen.main.bounds.width - 60) / 3)
                                        VStack{
                                            Spacer()
                                            Text(Dev.models[index].type).foregroundColor(.white).frame(width: (UIScreen.main.bounds.width - 60) / 3, height: 20).background(.black.opacity(0.5)).font(.system(size: 12))
                                        }
                                    }
                                    
                                }).cornerRadius(10)
                            }
                            
                            Button(action: {
                                startModels = true
                            }, label: {
                                ZStack{
                                    Image(Dev.models[2].icon)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (UIScreen.main.bounds.width - 60) / 3,height: (UIScreen.main.bounds.width - 60) / 3)
                                    
                                    Text("More").frame(width: (UIScreen.main.bounds.width - 60) / 3,height: (UIScreen.main.bounds.width - 60) / 3)
                                        .foregroundColor(.white)
                                        .background(.black.opacity(0.5))
                                    
                                    
                                }
                                
                            }).cornerRadius(10)
                        }
                    }
                    Spacer().frame(height: 20)
                    //尺寸
                    VStack{
                        HStack{
                            Text("Scale：\(size)").foregroundColor(.white).bold()
                            Spacer()
                        }
                        //512x512->1:1 640x360->16:9 640x480->4:3 512x680->3:4 720x1280->9:16
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 10){
                                ForEach(0..<Dev.sizes.count){index in
                                    Button(action: {
                                        Dev.currentSize = Dev.sizes[index]
                                        size = Dev.sizes[index].type
                                    }, label: {
                                        VStack{
                                            Image(Dev.sizes[index].icon)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill).frame(width: 20, height: 20)
                                            Text(Dev.sizes[index].type).foregroundColor(.black).font(.system(size: 12))
                                        }.frame(width: 80, height: 80)
                                        
                                    }).background(.white).cornerRadius(10)
                                    
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height: 120)
                    
                }.padding(.horizontal, 20)
            }
            
            VStack{
                Spacer()
                
                Button(action: {
                    if descpirtion.isEmpty{
                        showToast = true
                    }else{
                        showLoading = true
                        let content = "\(descpirtion),\(style),\(model)"
                        Dev.getAiImage(content: content){result in
                            showLoading = false
                            imageCode = result
                            (width, height) = Dev.getWH()
                            print("width = \(width), height = \(height)")
                            startImage = true
                        }
                    }
                    
                }, label: {
                    Text("Generate")
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .frame(width: UIScreen.main.bounds.width - 40,height: 60)
                        .font(.system(size: 16, weight: .bold))
                }).background(Color.chatButton)
                    .cornerRadius(10)
            }
            
            if showLoading{
                LoadingView(text: "Generating, please wait...")
            }
            
            if showToast{
                ToastView(message: "Descprition is empty", isShowing: $showToast)
            }
            
            NavigationLink(destination: AIImagePage(imageCode: imageCode, width: width, height: height), isActive: $startImage){EmptyView()}
            
            NavigationLink(destination: StylesPage(), isActive: $startStyles){EmptyView()}
            NavigationLink(destination: ModelsPage(), isActive: $startModels){EmptyView()}
        }.onDisappear{
            showLoading = false
        }.onAppear{
            style = (Dev.currentStyle == nil) ? style : Dev.currentStyle!.type
            model = (Dev.currentModel == nil) ? model : Dev.currentModel!.type
            size = (Dev.currentSize == nil) ? size : Dev.currentSize!.type
        }.navigationBarHidden(showLoading)
    }
}

