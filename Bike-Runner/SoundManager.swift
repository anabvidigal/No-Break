//
//  SoundManager.swift
//  Bike-Runner
//
//  Created by Bittenco on 12/03/22.
//

import Foundation
import SwiftySound

class SoundManager {
    private var repository: ConfigRepository
    var musicIsOn = true
    var soundIsOn = true
    
    init(repository: ConfigRepository) {
        self.repository = repository
        Sound.category = .playback
    }
    
    func playTapSound() {
        if soundIsOn {
            Sound.play(file: "tap", fileExtension: "wav")
        }
    }
    
    func playSelectSound() {
        if soundIsOn {
            Sound.play(file: "select", fileExtension: "wav")
        }
    }
    
    func playSuccessSound() {
        if soundIsOn {
            Sound.play(file: "success-sound-1", fileExtension: "wav")
        }
    }
    
    func playCoinSound() {
        if soundIsOn {
            Sound.play(file: "coin", fileExtension: "wav")
        }
    }
    
    func playPlayerDieSound() {
        if soundIsOn {
            Sound.play(file: "player-die", fileExtension: "wav")            
        }
    }
    
    func playGameMusic() {
        if musicIsOn {
            Sound.play(file: "game-music", fileExtension: "wav", numberOfLoops: -1)
        }
    }
    
    func stopGameMusic() {
        Sound.stop(file: "game-music", fileExtension: "wav")
    }
    
    func playMenuMusic() {
        if musicIsOn {
            Sound.play(file: "menu-music", fileExtension: "wav", numberOfLoops: -1)
        }
    }
    
    func stopMenuMusic() {
        Sound.stop(file: "menu-music", fileExtension: "wav")
    }
    
    
}
