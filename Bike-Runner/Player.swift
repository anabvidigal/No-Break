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
    private var speedManager: SpeedManager
    private var hapticsManager: HapticsManager?
    var biker: Biker
    
    var status: LaneBikeStatus = .topLane
    
    init(node: SKSpriteNode, speedManager: SpeedManager, biker: Biker) {
        self.node = node
        self.startPosition = node.position
        self.speedManager = speedManager
        self.biker = biker
        status = .topLane
        physicsSetup()
    }
    
    func physicsSetup() {
        let body = SKPhysicsBody(circleOfRadius: 60)
        body.isDynamic = true
        body.affectedByGravity = false
        body.categoryBitMask = Constants.bikeTopLaneCategory
        body.collisionBitMask = Constants.bikeCollision
        node.physicsBody = body
    }
    
    func changeLane() {
        switch status {
        case .topLane:
            setBottomLane()
        case .bottomLane:
            setTopLane()
        }
    }
    
    private func setBottomLane() {
        node.position.y = Constants.bikeBottomLane
        status = .bottomLane
        node.physicsBody?.categoryBitMask = Constants.bikeBottomLaneCategory
        node.physicsBody?.contactTestBitMask = Constants.bikeBottomLaneContact
    }
    
    private func setTopLane() {
        node.position.y = Constants.bikeTopLane
        status = .topLane
        node.physicsBody?.categoryBitMask = Constants.bikeTopLaneCategory
        node.physicsBody?.contactTestBitMask = Constants.bikeTopLaneContact
    }
    
    func die() {
        node.removeAllActions()
    }
    
    func reset() {
        startAnimation()
    }
    
    func startAnimation() {
        var textures = [SKTexture]()
        textures.append(SKTexture(imageNamed: "\(biker.id)_frame_1"))
        textures.append(SKTexture(imageNamed: "\(biker.id)_frame_2"))
        textures.append(SKTexture(imageNamed: "\(biker.id)_frame_3"))
        textures.append(SKTexture(imageNamed: "\(biker.id)_frame_4"))
        textures.append(SKTexture(imageNamed: "\(biker.id)_frame_5"))
        textures.append(SKTexture(imageNamed: "\(biker.id)_frame_6"))
        
        let frames = SKAction.animate(with: textures, timePerFrame: 0.09, resize: false, restore: false)
        let repeatAnim = SKAction.repeatForever(frames)
        node.run(repeatAnim)
    }
}
    
enum LaneBikeStatus {
    case topLane
    case bottomLane
}
