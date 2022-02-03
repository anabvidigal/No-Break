//
//  Coin.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation
import SpriteKit

class Coin {
    
    var node: SKNode
    
    init(node: SKNode) {
        self.node = node.copy() as! SKSpriteNode
        physicsSetup()
    }
    
    private func physicsSetup() {
        let body = SKPhysicsBody(circleOfRadius: 20)
        body.isDynamic = true
        body.affectedByGravity = false
        body.collisionBitMask = Constants.coinCollision
        body.categoryBitMask = 0
        node.physicsBody = body
        
    }
    
    func setLane(lane: Lane) {
        switch lane {
        case .topLane:
            node.physicsBody?.categoryBitMask = Constants.coinTopLaneCategory
        case .bottomLane:
            node.physicsBody?.categoryBitMask = Constants.coinBottomLaneCategory
        }
    }
    
}
