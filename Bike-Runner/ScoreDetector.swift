//
//  ScoreManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 02/02/22.
//

import Foundation
import SpriteKit

class ScoreDetector {
    var node: SKNode
    
    init(node: SKNode){
        self.node = node
        setupPhysics()
    }
    
    private func setupPhysics() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 700))
        body.isDynamic = true
        body.affectedByGravity = false
        body.collisionBitMask = Constants.scoreDetectorCollision
        body.contactTestBitMask = Constants.scoreDetectorContact
        node.physicsBody = body
    }
}
