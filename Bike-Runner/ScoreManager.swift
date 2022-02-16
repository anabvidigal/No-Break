//
//  ScoreManager.swift
//  Bike-Runner
//
//  Created by André Schueda on 16/02/22.
//

import Foundation

class ScoreManager {
    private var gameCenter: GameCenter
    private var repository: HighscoreRepository
    
    var highscore: Int
    var currentScore: Int = 0
    var currentScoreIsHighscore = false
    
    init(gameCenter: GameCenter, repository: HighscoreRepository){
        self.repository = repository
        self.gameCenter = gameCenter
        
        highscore = repository.getHighscore()
    }
    
    func incrementScore() {
        currentScore += 1
        checkAchievements()
        checkHighscore()
    }
    
    func setHighscore() {
        if currentScoreIsHighscore {
            repository.save(new: highscore)
        }
    }
    
    private func checkAchievements() {
        if currentScore == 10 {
            gameCenter.unlock10PointsAchievement()
        }
        if currentScore == 30 {
            gameCenter.unlock30PointsAchievement()
        }
    }
    
    private func checkHighscore() {
        if currentScore > highscore {
            currentScoreIsHighscore = true
            highscore = currentScore
        }
    }
    
    func resetScore() {
        currentScore = 0
        currentScoreIsHighscore = false
    }
}
