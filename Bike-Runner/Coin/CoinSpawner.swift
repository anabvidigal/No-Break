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
    var coins: [Coin] = []
    
    
    init(coinNode: SKNode) {
        self.coinNode = coinNode
        coinNode.removeFromParent()
    }
    
    // randomize when coin appears
    func randomizeCoinSpawn(parent: SKNode, lane: Lane) {
        if Int.random(in: 1...100) < Constants.coinRate {
            let new = Coin(node: coinNode)
            new.setLane(lane: lane)
            parent.addChild(new.node)
            coins.append(new)
        }
    }
    
    func removeCoin() {
        if let firstCoin = coins.first {
            firstCoin.node.removeFromParent()
            coins.removeFirst()
        }
    }
    
    func reset() {
        for coin in coins {
            coin.node.removeFromParent()
        }
        coins.removeAll()
    }
    
}
