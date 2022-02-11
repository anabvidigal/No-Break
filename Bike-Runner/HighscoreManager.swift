//
//  HighscoreManager.swift
//  Bike-Runner
//
//  Created by André Schueda on 10/02/22.
//

import Foundation

class HighscoreManager {
    private var repository: HighscoreRepository
    var highscore: Int
    
    init(repository: HighscoreRepository) {
        self.repository = repository
        highscore = repository.getHighscore()
    }
    
    func setIfHighscore(for score: Int) -> Bool {
        if isHighscore(score: score) {
            repository.save(new: score)
            return true
        }
        return false
    }
    
    func isHighscore(score: Int) -> Bool {
        score > highscore ? true : false
    }
}
