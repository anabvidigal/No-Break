//
//  CoinSpawner.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation
import SpriteKit

class CoinSpawner {
    
    var coinNode: SKNode
    var parent: SKNode
    
    init(coinNode: SKNode, parent: SKNode) {
        self.coinNode = coinNode
        self.parent = parent
    }
    
    // randomize when coin appears
    func randomizeCoinSpawn() {
        if Int.random(in: 1...100) < 65 {
            coinNode.removeFromParent()
        }
    }
    
    
    
}
