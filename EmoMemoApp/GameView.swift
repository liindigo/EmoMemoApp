//
//  ContentView.swift
//  OrangeGroup-GamesApp
//
//  Created by Anastasia Kantor on 2020-11-24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameController
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.presentationMode) var presentationMode
    let layoutGameView = [ GridItem(.flexible()), GridItem(.flexible()) ]
    @State private var isDisabled = false
    @State private var youWin = false
    @State var isSoundOn: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.init(red: 238/255, green: 11/255, blue: 11/255, opacity: 1.0), Color.init(red: 122/255, green: 36/255, blue: 225/255, opacity: 1.0)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                LazyVGrid(columns: layoutGameView, spacing: 20) {
                    ForEach(0..<game.values.count, id: \.self) {number in
                        let front = Image(systemName: game.backSideImageName)
                            .resizable()
                            .padding(30)
                            .foregroundColor(.init(red: 255/255, green: 255/255, blue: 255/255))
                            .background(Color.init(red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                            .shadow(color: .purple, radius: 10, x: 0.0, y: 0.0)

                        
                        let back = Image(game.values[number]).resizable()
                        CardView(id: number,
                                 isFaceUp: $game.isCardFaceUp[number],
                                 isDone: $game.isCardGuessed[number],
                                 callback: userTapHandler,
                                 sound: getSound(number: number),
                                 front: front,
                                 back: back)
                            .frame(width: CardSize(), height: CardSize())
                            .cornerRadius(15)
                    }
                    .shadow(color: .black, radius: 10, x: 5.0, y: 8.0)
                    
                }.padding().disabled(isDisabled)
                
                HStack {
                    Spacer()
                    
                    Image(systemName: game.isSoundOn ? "speaker.fill": "speaker.slash.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .onTapGesture(perform: {
                            game.isSoundOn = !game.isSoundOn
                        })
                        .shadow(color: .black, radius: 10, x: 5.0, y: 8.0)
                    Spacer()
                    
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .onTapGesture(perform: {
                            presentationMode.wrappedValue.dismiss()
                        })
                        .shadow(color: .black, radius: 10, x: 5.0, y: 8.0)
                    Spacer()
                    
                    Image(systemName: "repeat")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .onTapGesture(perform: {
                            game.reset()
                        })
                        .shadow(color: .black, radius: 10, x: 5.0, y: 8.0)
                    Spacer()
                }
                .padding()
            }
        
            VStack {
                
                Image("PojkeWin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                    
                    
            }
            .opacity(game.foundMatch ? 1 : 0)
            .frame(width: game.foundMatch ? UIScreen.main.bounds.width : 0, height: game.foundMatch ? UIScreen.main.bounds.height : 0)
            .animation(.easeInOut(duration: 0.5))
        }
    }
    
    func userTapHandler(id: Int) {
        
        if game.isItFirstCard {
            game.compareCards(id: id)  // no delay if it was a first card
            return
        }
        
        isDisabled = true    // activities blocked while cards are compaired
        // little delay to see both unmatched cards - can be longer
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            game.compareCards(id: id)
            isDisabled = false
            youWin = game.isGameOver
            
            if youWin {
                if let soundOn = UserDefaults.standard.object(forKey: "isSoundOn") {
                    if soundOn as! Bool {
                        EffectPlayer.shared.effectSound(effect: "WinSound")
                    }
                } else {
                    EffectPlayer.shared.effectSound(effect: "WinSound")
                }
            }
            // check if the game is over
            
            //TODO: effect for Game Over
        }
    }
    
    private func sizeGameView() -> CGFloat {
        return UIScreen.main.bounds.width/3
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
    
    private func getSound(number: Int) -> String {
        let emotion = game.values[number]
        switch emotion {
        case "Pappaglad": return "Man-laugh"
        case "Pappaledsen": return "Man-cry"
        case "Pappaarg": return "Man-angry"
        case "Mammaglad": return "Woman-laugh"
        case "Mammaledsen": return "Woman-cry"
        case "Mammaarg": return "Woman-angry"
        case "Pojkeglad": return "Kid-laugh"
        case "Pojkeledsen": return "Kid-cry"
        case "Pojkearg": return "Kid-angry"
        default: fatalError("unknown emotion value")
        }
        
    }
}
