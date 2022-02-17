//
//  CoinsManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation
import SpriteKit

class CoinManager {
    private var repository: CoinsRepository
    var playerCoins: Int
    var collectedCoins: Int = 0
    
    init(repository: CoinsRepository) {
        self.repository = repository
        playerCoins = repository.getCoins()
    }
    
    func incrementCoins() {
        collectedCoins += 1
    }
    
    func doubleCoins() {
        collectedCoins *= 2
    }
    
    func addCollectedCoins() {
        playerCoins += collectedCoins
        repository.add(coins: collectedCoins)
        collectedCoins = 0
    }
    
    func spend(coins: Int) {
        playerCoins -= coins
        repository.spend(coins: coins)
    }
    
    func hitTheJackpot() {
        collectedCoins = 99999
        addCollectedCoins()
    }
    
    func goPoor() {
        spend(coins: playerCoins)
    }
}
