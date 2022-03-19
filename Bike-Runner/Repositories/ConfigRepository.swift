//
//  ConfigRepository.swift
//  Bike-Runner
//
//  Created by André Schueda on 19/03/22.
//

import Foundation

protocol ConfigRepository {
    func save(hapticsIsOn: Bool)
    func hapticsIsOn() -> Bool
    func save(soundIsOn: Bool)
    func soundIsOn() -> Bool
    func save(musicIsOn: Bool)
    func musicIsOn() -> Bool
}

class UserDefaultsConfigRepository: ConfigRepository {
    private let hapticsKey = "haptics"
    private let soundKey = "sound"
    private let musicKey = "music"
    
    func save(hapticsIsOn: Bool) {
        UserDefaults.standard.setValue(hapticsIsOn, forKey: hapticsKey)
    }
    
    func hapticsIsOn() -> Bool {
        UserDefaults.standard.bool(forKey: hapticsKey)
    }
    
    func save(soundIsOn: Bool) {
        UserDefaults.standard.setValue(soundIsOn, forKey: soundKey)
    }
    
    func soundIsOn() -> Bool {
        UserDefaults.standard.bool(forKey: soundKey)
    }
    
    func save(musicIsOn: Bool) {
        UserDefaults.standard.setValue(musicIsOn, forKey: musicKey)
    }
    
    func musicIsOn() -> Bool {
        UserDefaults.standard.bool(forKey: musicKey)
    }
}
