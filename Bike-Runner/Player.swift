//
//  Player.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import Foundation
import SpriteKit

class Player {
    
    var node: SKSpriteNode
    private var startPosition: CGPoint
    private var speedManager: SpeedManager!
    
    var status: LaneBikeStatus = .topLane
    
    init(node: SKSpriteNode, speedManager: SpeedManager) {
        self.node = node
        self.startPosition = node.position
        self.speedManager = speedManager
        status = .topLane
        physicsSetup()
    }
    
    func physicsSetup() {
        let body = SKPhysicsBody(circleOfRadius: 60)
        body.isDynamic = true
        body.affectedByGravity = false
        body.categoryBitMask = Constants.bikeTopLaneCategory
        body.contactTestBitMask = 0
        body.collisionBitMask = Constants.bikeCollision
        node.physicsBody = body
    }
    
    func changeLane() {
        
        switch status {
        case .topLane:
            node.position.y = -124
            status = .bottomLane
            node.physicsBody?.categoryBitMask = Constants.bikeBottomLaneCategory

        case .bottomLane:
            node.position.y = -74
            status = .topLane
            node.physicsBody?.categoryBitMask = Constants.bikeTopLaneCategory
        }
    }
    
    func die() {
        node.removeAllActions()
    }
    
    func reset() {
        startAnimation()
    }
    
    func startAnimation() {
        var textures = [SKTexture]()
        textures.append(SKTexture(imageNamed: "fixed_frame_1"))
        textures.append(SKTexture(imageNamed: "fixed_frame_2"))
        textures.append(SKTexture(imageNamed: "fixed_frame_3"))
        textures.append(SKTexture(imageNamed: "fixed_frame_4"))
        textures.append(SKTexture(imageNamed: "fixed_frame_5"))
        textures.append(SKTexture(imageNamed: "fixed_frame_6"))
        
        let frames = SKAction.animate(with: textures, timePerFrame: 0.09, resize: false, restore: false)
        let repeatAnim = SKAction.repeatForever(frames)
        node.run(repeatAnim)
    }
}
    
enum LaneBikeStatus {
    case topLane
    case bottomLane
}
