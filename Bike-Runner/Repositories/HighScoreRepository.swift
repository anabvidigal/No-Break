//
//  HighScoreRepository.swift
//  Bike-Runner
//
//  Created by André Schueda on 10/02/22.
//

import Foundation

protocol HighScoreRepository {
    func save(new highscore: Int)
    func getHighscore() -> Int
    func resetHighscore()
}

class UserDefaultsHighScoreRepository: HighScoreRepository {
    private let key = "highscore"
    
    func save(new highscore: Int) {
        UserDefaults.setValue(highscore, forKey: key)
    }
    
    func getHighscore() -> Int {
        guard let highscore = UserDefaults.value(forKey: key) as? Int else { return 0 }
        return highscore
    }
    
    func resetHighscore() {
        UserDefaults.setValue(0, forKey: key)
    }
    
    
}
