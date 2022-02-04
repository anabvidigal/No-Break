//
//  GameCenter.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 04/02/22.
//

import Foundation
import GameKit


class GameCenter {
    
    // Leaderboards
    
    func submitScore(score: Int) {
        Task {
            do {
                try await GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["0001"])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    // Achievements
    
    func unlockAchievement() {
        let achievement = GKAchievement(identifier: "30_points")
        achievement.percentComplete = 100
        achievement.showsCompletionBanner = true
        GKAchievement.report([achievement]) { error
            in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print ("done")
        }
    }
    
    func resetAchievement() {
        GKAchievement.resetAchievements()
    }
}