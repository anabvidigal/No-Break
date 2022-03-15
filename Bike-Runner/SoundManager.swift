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
            Sound.play(file: "tap", fileExtension: "wav")
        } else {
            print("Tap sound disabled. Enable in SoundManager")
        }
    }
    
    func playSelectSound() {
        Sound.play(file: "select", fileExtension: "wav")
    }
    
    func playSuccessSound() {
        Sound.play(file: "success-sound-1", fileExtension: "wav")
    }
    
    func playCoinSound() {
        Sound.play(file: "coin", fileExtension: "wav")
    }
    
    func playPlayerDieSound() {
        Sound.play(file: "player-die", fileExtension: "wav")
    }
    
    func playGameMusic() {
        Sound.play(file: "game-music", fileExtension: "wav", numberOfLoops: -1)
    }
    
    func stopGameMusic() {
        Sound.stop(file: "game-music", fileExtension: "wav")
    }
    
    func playMenuMusic() {
        Sound.play(file: "menu-music", fileExtension: "wav", numberOfLoops: -1)
    }
    
    func stopMenuMusic() {
        Sound.stop(file: "menu-music", fileExtension: "wav")
    }
    
    
}
