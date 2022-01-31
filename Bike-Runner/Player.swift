//
//  Player.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import Foundation
import SpriteKit

class Player {
    
    private var node: SKSpriteNode
    private var startPosition: CGPoint
    
    var status: LaneBikeStatus = .topLane
    
    init(node: SKSpriteNode) {
        self.node = node
        self.startPosition = node.position
        status = .topLane
        physicsSetup()
    }
    
    func physicsSetup() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width:132, height: 132))
        body.isDynamic = true
        body.affectedByGravity = false
        body.categoryBitMask = Constants.bikeTopLaneCategory
        body.contactTestBitMask = 0
        body.collisionBitMask = Constants.bikeCollision
        node.physicsBody = body
        print("bike contact: \(body.contactTestBitMask)")
        print("bike category: \(body.categoryBitMask)")
    }
    
    func changeLane() {
        
        switch status {
        case .topLane:
            node.position.y = -243
            status = .bottomLane
            node.zPosition = 0
            node.physicsBody?.categoryBitMask = Constants.bikeBottomLaneCategory

        case .bottomLane:
            node.position.y = -185
            status = .topLane
            node.zPosition = 5
            node.physicsBody?.categoryBitMask = Constants.bikeTopLaneCategory
        }
        print("bike contact: \(node.physicsBody?.contactTestBitMask)")
        print("bike category: \(node.physicsBody?.categoryBitMask)")
    }
    
    func die() {
        node.yScale = -0.4
    }
    
    func startAnimation() {
        var textures = [SKTexture]()
        textures.append(SKTexture(imageNamed: "fixie_rider1"))
        textures.append(SKTexture(imageNamed: "fixie_rider2"))
        textures.append(SKTexture(imageNamed: "fixie_rider3"))
        textures.append(SKTexture(imageNamed: "fixie_rider4"))
        textures.append(SKTexture(imageNamed: "fixie_rider5"))
        textures.append(SKTexture(imageNamed: "fixie_rider6"))
        
        let frames = SKAction.animate(with: textures, timePerFrame: 0.1, resize: false, restore: false)
        let repeatAnim = SKAction.repeatForever(frames)
        node.run(repeatAnim)
    }
        
}
    
enum LaneBikeStatus {
    case topLane
    case bottomLane
}
