//
//  HapticsManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt on 08/03/22.
//

import UIKit

class HapticsManager {
    private var repository: ConfigRepository
    var vibrationIsOn = true
    
    init(repository: ConfigRepository) {
        self.repository = repository
    }
    
    func toggleVibration() {
        vibrationIsOn = !vibrationIsOn
    }
    
    func changeLaneVibrate() {
        if vibrationIsOn {
            DispatchQueue.main.async {
                let changeLaneFeedbackGenerator = UISelectionFeedbackGenerator()
                changeLaneFeedbackGenerator.prepare()
                changeLaneFeedbackGenerator.selectionChanged()
            }
        }
    }
    
    func playerDiedVibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        if vibrationIsOn {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
    
    func catchCoinVibrate() {
        if vibrationIsOn {
            let catchCoinVibrateGenerator = UIImpactFeedbackGenerator(style: .medium)
            catchCoinVibrateGenerator.prepare()
            catchCoinVibrateGenerator.impactOccurred()            
        }
    }
    
}
