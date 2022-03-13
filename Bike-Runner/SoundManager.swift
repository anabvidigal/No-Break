//
//  SoundManager.swift
//  Bike-Runner
//
//  Created by Bittenco on 12/03/22.
//

import Foundation
import SwiftySound

class SoundManager {
    
    var playBool = true
    
    // habilitar ou desabilitar os sons de taps em botoes pra testar se fica legal
    
    func playTapSound() {
        if playBool == true {
            Sound.play(file: "tap.wav")
        } else {
            print("Tap sound disabled. Enable in SoundManager")
        }
    }
    
    
}
