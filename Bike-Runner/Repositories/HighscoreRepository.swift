//
//  HighscoreRepository.swift
//  Bike-Runner
//
//  Created by André Schueda on 10/02/22.
//

import Foundation

protocol HighscoreRepository {
    func save(new highscore: Int)
    func getHighscore() -> Int
    func resetHighscore()
}

class UserDefaultsHighScoreRepository: HighscoreRepository {
    private let key = "highscore"
    
    func save(new highscore: Int) {
        UserDefaults.standard.setValue(highscore, forKey: key)
    }
    
    func getHighscore() -> Int {
        let highscore = UserDefaults.standard.integer(forKey: key)
        return highscore
    }
    
    func resetHighscore() {
        UserDefaults.standard.setValue(0, forKey: key)
    }
    
    
}
