//
//  ScanPage.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/7/31.
//

import SwiftUI

struct ScanPage: View {
    @State private var scannedCode = ""
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @State private var isLoading: Bool = false
    @State private var showToast = false
    @State private var isFlashlightOn = false
    @StateObject private var cameraManager = CameraManager()
    var body: some View {
        ZStack {
            Color.pageBackground.edgesIgnoringSafeArea(.all)
            VStack{
                
                CameraScannerView { code in
                    self.scannedCode = code
                }
                .frame(width: 220, height: 220)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 5)
                ).padding(.top, 10)
                
                HStack{
                    Button(action: {
                        isImagePickerPresented = true
                    }){
                        HStack{
                            Image("ic_select").resizable()
                                .scaledToFit().frame(width: 25,height: 25)
                            
                            Text("Select").foregroundColor(.white)
                        }.padding()
                        
                    }.background(Color.chatButton).cornerRadius(10).sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker { image in
                            selectedImage = image
                            startLoading()
                            QRCodeDetector.detectQRCode(in: image) { code in
                                self.scannedCode = code ?? "Scaning Error"
                                stopLoading()
                            }
                        }
                    }
                    
                    Spacer().frame(width: 20)
                    
                    Button(action: {
                        isFlashlightOn.toggle()
                                        cameraManager.toggleFlashlight(on: isFlashlightOn)
                    }){
                        HStack{
                            Image("ic_light").resizable()
                                .scaledToFit().frame(width: 25,height: 25)
                            
                            Text(isFlashlightOn ? "Turn off" : "Turn on").foregroundColor(.white)
                                                
                        }.padding()
                        
                    }.background(Color.chatButton).cornerRadius(10)
                }.padding(.top, 20)
               
                if scannedCode.isEmpty{
                    
                }else{
                    Button(action: {
                        UIPasteboard.general.string = scannedCode
                        showToast = true
                    }){
                        Text("Scan result:\(scannedCode)").foregroundColor(.white).padding()
                        
                    }.background(Color.chatButton).cornerRadius(10).padding()
                }
                
                
                
                
                Spacer()
            }
            if isLoading {
                LoadingView(text: "Scanning")
            }
            
            if showToast{
                ToastView(message: "Copy Success", isShowing: $showToast)
            }
        }
        
    }
    
    private func startLoading() {
        isLoading = true
    }
    
    private func stopLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            isLoading = false
        }
    }
}
