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
    private let sessionsCountKey = "sessionsCount"
    
    func save(hapticsIsOn: Bool) {
        UserDefaults.standard.setValue(hapticsIsOn, forKey: hapticsKey)
    }
    
    func hapticsIsOn() -> Bool {
        if getSessionCount() > 1 {
            return UserDefaults.standard.bool(forKey: hapticsKey)
        }
        return true
    }
    
    func save(soundIsOn: Bool) {
        UserDefaults.standard.setValue(soundIsOn, forKey: soundKey)
    }
    
    func soundIsOn() -> Bool {
        if getSessionCount() > 1 {
            return UserDefaults.standard.bool(forKey: soundKey)
        }
        return true
    }
    
    func save(musicIsOn: Bool) {
        UserDefaults.standard.setValue(musicIsOn, forKey: musicKey)
    }
    
    func musicIsOn() -> Bool {
        if getSessionCount() > 1 {
            return UserDefaults.standard.bool(forKey: musicKey)
        }
        return true
    }
    
    func incrementSessionCount() {
        var sessionCount = UserDefaults.standard.integer(forKey: sessionsCountKey)
        sessionCount += 1
        UserDefaults.standard.setValue(sessionCount, forKey: sessionsCountKey)
    }
    
    func getSessionCount() -> Int {
        UserDefaults.standard.integer(forKey: sessionsCountKey)
    }
}
