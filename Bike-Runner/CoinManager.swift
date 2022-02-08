//
//  CoinsManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation
import SpriteKit

class CoinManager {
    
    var coins: Int = 0
    
    func incrementCoins() {
        coins += 1
    }
    
    func resetCoins() {
        coins = 0
    }
}
