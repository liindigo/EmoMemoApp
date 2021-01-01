//
//  MatchingCode.swift
//  OrangeGroup-GamesApp
//
//  Created by Anastasia Kantor on 2020-12-15.
//

import Foundation
import SwiftUI

struct CardView<Front: View, Back: View>:View {
    var id: Int
    @Binding var isFaceUp: Bool
    @Binding var isDone: Bool
    var callback: (Int) -> ()
    var sound: String
    let front: Front
    let back: Back
    
    @State var angleState = TranslatingAngleState()
    
    var body: some View {
        ZStack(alignment: .center) {
            front
                .opacity(angleState.showingFront ? 1.0 : 0.0)
            back
                .scaleEffect(CGSize(width: -1.0, height: 1.0))
                .opacity(angleState.showingFront ? 0.0 : 1.0)
        }
        .frame(minWidth: 0.0, maxWidth: .infinity, alignment: .center)
        .rotation3DEffect(
            .degrees(angleState.total),
            axis: (x: 0.0, y: 1.0, z: 0.0),perspective: 0.5)
        .onTapGesture {
            if isFaceUp { return }
            isFaceUp.toggle()      // turn card
            callback(id)           // send card id to main func
        }.onChange(of: isFaceUp, perform: { _ in
            var currentState = self.angleState
            currentState.angle -= 180.0
            currentState.angleTranslation = 0.0
            withAnimation{
                self.angleState = currentState
            }
            if !angleState.showingFront {
                if let soundOn = UserDefaults.standard.object(forKey: "isSoundOn") {
                    if soundOn as! Bool {
                        EffectPlayer.shared.effectSound(effect: sound)
                    }
                } else {
                    EffectPlayer.shared.effectSound(effect: sound)
                }
            }
        })
    }
}

struct TranslatingAngleState{
    var angle: Double = 0.0
    var angleTranslation: Double = 0.0
    
    var total: Double {
        angle + angleTranslation
    }
    
    var clamped: Double{
        var clampedAngle = angleTranslation + angle
        while clampedAngle < 360.0 {
            clampedAngle += 360
        }
        return clampedAngle.truncatingRemainder(dividingBy: 360.0)
    }
    
    var showingFront: Bool {
        let clampedAngle = clamped
        return clampedAngle < 90.0 || clampedAngle > 270.0
    }
}
