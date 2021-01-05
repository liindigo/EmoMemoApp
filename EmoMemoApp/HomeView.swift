//
//  HomeView.swift
//  EmoMemoApp
//
//  Created by Linda Levin on 2020-12-29.
//

import Foundation

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State var goToMamma = false
    @State var goToPappa = false
    @State var goToPojke = false
    @State var goToFlicka = false
    @State var goToHund = false
    @State var goToKatt = false
    
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.init(red: 238/255, green: 11/255, blue: 11/255, opacity: 1.0), Color.init(red: 122/255, green: 36/255, blue: 225/255, opacity: 1.0)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Label("Pick a Memo", systemImage: "arrow.down.square.fill")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    
                HStack {
                    VStack {    // Button Pojke
                        Image("Pojkeglad")
                            .resizable()
                            .frame(width: 2/3*CardSize(), height: 2/3*size(), alignment: .center)
                       
                    }
                    .frame(width: size(), height: size(), alignment: .center)
                    .onTapGesture(perform: {
                        goToPojke = true
                    }).modifier(ButtonModifier())
                    .shadow(color: .black, radius: 10, x: 0.5, y: 0.0)
                    
                    VStack {    // Button Flicka
                        Image("flickaglad")
                            .resizable()
                            .frame(width: 2/3*size(), height: 2/3*size(), alignment: .center)
                       
                    }
                    .frame(width: size(), height: size(), alignment: .center)
                    .onTapGesture(perform: {
                        goToFlicka = true
                    }).modifier(ButtonModifier())
                    .shadow(color: .black, radius: 10, x: 0.5, y: 0.0)
                }.padding()
                
                HStack {
                    VStack {    // Button Pappa
                        Image("Pappaglad")
                            .resizable()
                            .frame(width: 2/3*size(), height: 2/3*size(), alignment: .center)
                        
                    }
                    .frame(width: size(), height: size(), alignment: .center)
                    .onTapGesture(perform: {
                        goToPappa = true
                    }).modifier(ButtonModifier())
                    .shadow(color: .black, radius: 10, x: 0.5, y: 0.0)
                    
                    VStack {    // Button Mamma
                        Image("Mammaglad")
                            .resizable()
                            .frame(width: 2/3*size(), height: 2/3*size(), alignment: .center)
                       
                    }
                    .frame(width: size(), height: size(), alignment: .center)
                    .onTapGesture(perform: {
                        goToMamma = true
                    }).modifier(ButtonModifier())
                    .shadow(color: .black, radius: 10, x: 0.5, y: 0.0)
                }
                
                HStack {
                    VStack {    // Button Katt
                        Image("kattmjau")
                            .resizable()
                            .frame(width: 2/3*size(), height: 2/3*size(), alignment: .center)
                        
                    }
                    .frame(width: size(), height: size(), alignment: .center)
                    .onTapGesture(perform: {
                        goToKatt = true
                    }).modifier(ButtonModifier())
                    .shadow(color: .black, radius: 10, x: 0.5, y: 0.0)
                    
                    VStack {    // Button Hund
                        Image("hundglad")
                            .resizable()
                            .frame(width: 2/3*size(), height: 2/3*size(), alignment: .center)
                       
                    }
                    .frame(width: size(), height: size(), alignment: .center)
                    .onTapGesture(perform: {
                        goToHund = true
                    }).modifier(ButtonModifier())
                    .shadow(color: .black, radius: 10, x: 0.5, y: 0.0)
                }.padding()
                
            }
            Group {
                EmptyView().fullScreenCover(isPresented: $goToMamma) {
                    GameView(game: GameController(["Mammaglad", "Mammaarg", "Mammaledsen"], "star"))
                }
                EmptyView().fullScreenCover(isPresented: $goToPappa) {
                    GameView(game: GameController(["Pappaarg", "Pappaglad", "Pappaledsen"], "star"))
                }
                EmptyView().fullScreenCover(isPresented: $goToPojke) {
                    GameView(game: GameController(["Pojkeglad", "Pojkearg", "Pojkeledsen"], "heart.fill"))
                }
                EmptyView().fullScreenCover(isPresented: $goToFlicka) {
                    GameView(game: GameController(["flickaglad", "flickaarg", "flickaledsen"], "heart.fill"))
                }
                EmptyView().fullScreenCover(isPresented: $goToKatt) {
                    GameView(game: GameController(["kattmjau", "kattarg", "kattspinn"], "eyes.inverse"))
                }
                EmptyView().fullScreenCover(isPresented: $goToHund) {
                    GameView(game: GameController(["hundglad", "hundarg", "hundyla"], "eyes.inverse"))
                }
            } .shadow(color: .black, radius: 10, x: 5.0, y: 8.0)
        }
    }
    
    func size() -> CGFloat {
        let height = UIScreen.main.bounds.height
        if horizontalSizeClass == .compact {
            return min(150, (height-280)/3)
        } else {
            return 250
        }
    }
    
    private func CardSize() -> CGFloat {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        if horizontalSizeClass == .compact {
            return min(width * 0.8/2, (height-225)/3)
        } else {
            return 250
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color.white)
            .cornerRadius(15)
    }
}
