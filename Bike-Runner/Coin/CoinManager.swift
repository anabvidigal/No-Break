//
//  CoinsManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation
import SpriteKit

class CoinManager {
    private var coinsRepository: CoinsRepository
    var playerCoins: Int
    var collectedCoins: Int = 0
    
    init(coinsRepository: CoinsRepository) {
        self.coinsRepository = coinsRepository
        playerCoins = coinsRepository.getCoins()
    }
    
    func incrementCoins() {
        collectedCoins += 1
    }
    
    func doubleCoins() {
        collectedCoins *= 2
    }
    
    func addCoins() {
        playerCoins += collectedCoins
        coinsRepository.add(coins: collectedCoins)
        collectedCoins = 0
    }
    
}
