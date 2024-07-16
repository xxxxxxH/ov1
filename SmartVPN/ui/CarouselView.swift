import SwiftUI

struct CarouselView: View {
    let images = Dev.chaterList
    let ItemClick:(ChaterEntity)->Void
    
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<images.count, id: \.self) { index in
                        ZStack{
                            Image(images[index].hBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width * 0.8 + 20, height: geometry.size.width * 0.8 * 3 / 4)
                                .clipped()
                                .cornerRadius(16)
                            
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white, lineWidth: 0)
                                )
                                .shadow(radius: 16)
                                .onTapGesture {
                                    ItemClick(images[index])
                                }
                            
                            VStack{
                                Spacer()
                                HStack{
                                    VStack(alignment:HorizontalAlignment.leading,spacing:4){
                                        Text(images[index].name).foregroundColor(.white).font(.system(size: 20)).fontWeight(.bold)
                                        Text(images[index].introduce).foregroundColor(.gray).lineLimit(1).font(.system(size: 15))
                                    }.padding(.horizontal,10)
                                    
                                    ZStack{
                                        Button(action: {
                                            ItemClick(images[index])
                                        }){
                                            Text("chat")
                                                .foregroundColor(.white)
                                                .padding(.horizontal,20)
                                                .padding(.vertical,10)
                                        }.background(Color.chatButton)
                                            .cornerRadius(10)
                                    }.frame(width: geometry.size.width * 0.25)
                                    
                                }.frame(width: geometry.size.width * 0.8 + 20, height: 80)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(
                                                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]),
                                                               startPoint: .top,
                                                               endPoint: .bottom)
                                            )
                                            .edgesIgnoringSafeArea(.all)
                                    )
                                
                            }.frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8 * 3 / 4)
                            
                        }.frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8 * 3 / 4).scaleEffect(index == currentIndex ? 1.0 : 0.9)
                            .animation(.easeInOut(duration: 0.5), value: currentIndex)
                        
                    }
                }
                .padding(.horizontal, (geometry.size.width - geometry.size.width * 0.8) / 2)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let threshold: CGFloat = 50 // Adjust as needed
                            if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(currentIndex + 1, images.count - 1)
                                }
                            } else if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(currentIndex - 1, 0)
                                }
                            }
                        }
                )
            }
            .content.offset(x: -CGFloat(currentIndex) * (geometry.size.width * 0.8 + 20))
            .frame(width: geometry.size.width, height: geometry.size.width * 0.8 * 3 / 4, alignment: .leading)
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % images.count
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

