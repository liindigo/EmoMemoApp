//
//  EffectPlayer.swift
//  OrangeGroup-GamesApp
//
//  Created by Rasmus Ohlsson on 2020-12-13.
//

import Foundation
import AVFoundation
/**
 func effectSound har en parameter i (effect: String) När funktionen kallas ska man specificera vilken ljudfil
 som ska spelas genom en string som heter "yes" eller "no". Filtyp behöver inte anges så länge alla våra
 effekter är i wav-format. EffectPlayern ska inte tysta MusicPlayer. Isåfall har det blivit fel.
 Ifall vi vill lägga till ett effektljud räcker det att lägga till en musikfil i -> Music files. Vi ska försöka att hålla oss
 bara till wav.format för att undvika fler parametrar.
 För att kalla på effectSound i en annan fil: Skriv
 //EffectPlayer.shared.effectSound(effect: "no")
 */
class EffectPlayer {
  static let shared = EffectPlayer()
  var soundPlayer: AVAudioPlayer?
  func effectSound(effect: String) {
    if let bundle = Bundle.main.path(forResource: effect, ofType: "wav") {
          let effectMusic = NSURL(fileURLWithPath: bundle)
          do {
            soundPlayer = try AVAudioPlayer(contentsOf:effectMusic as URL)
            guard let soundPlayer = soundPlayer else { return }
            soundPlayer.prepareToPlay()
            soundPlayer.play()
            print("Effect playing")
            } catch {
              print("error")
            }
    }
  }
}
