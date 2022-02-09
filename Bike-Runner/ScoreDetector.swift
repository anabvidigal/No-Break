//
//  ScoreManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 02/02/22.
//

import Foundation
import SpriteKit

class ScoreDetector {
    
    var score: Int = 0
    var node: SKNode
    private var gameCenter: GameCenter
    
    init(node: SKNode, gameCenter: GameCenter){
        self.node = node
        self.gameCenter = gameCenter
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
    
    func incrementScore() {
        score += 1
        if score == 30 {
            gameCenter.unlock30PointsAchievement()
        }
        if score == 10 {
            gameCenter.unlock10PointsAchievement()
        }
    }
    
    func resetScore() {
        score = 0
    }
    
}
