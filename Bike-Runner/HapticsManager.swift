//
//  HapticsManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt on 08/03/22.
//

import UIKit

class HapticsManager {
    
    func changeLaneVibrate() {
        DispatchQueue.main.async {
            let changeLaneFeedbackGenerator = UISelectionFeedbackGenerator()
            changeLaneFeedbackGenerator.prepare()
            changeLaneFeedbackGenerator.selectionChanged()
        }
    }
    
    func playerDiedVibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare()
        notificationGenerator.notificationOccurred(type)
    }
    
    func catchCoinVibrate() {
        let catchCoinVibrateGenerator = UIImpactFeedbackGenerator(style: .medium)
        catchCoinVibrateGenerator.prepare()
        catchCoinVibrateGenerator.impactOccurred()
    }
    
}
