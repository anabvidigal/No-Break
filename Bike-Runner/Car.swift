//
//  Car.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 01/02/22.
//

import Foundation
import SpriteKit

class Car {
    
    var carSpeed: CGFloat = .random(in: 1.8...2.2)
    var node: SKNode
    private var carTextures = [
        "car",
        "rounded_car",
        "jeep"
    ]
    
    init(node: SKSpriteNode) {
        self.node = node.copy() as! SKSpriteNode
        physicsSetup()
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLane(_ lane: Lane) {
        switch lane {
        case .topLane: setTopLane()
        case .bottomLane: setBottomLane()
        }
    }
    
    private func setTopLane() {
        node.position.y = -533
        node.physicsBody?.contactTestBitMask = Constants.carTopLaneContact
        node.physicsBody?.categoryBitMask = Constants.carTopLaneCategory
        node.zPosition = 1
    }
    
    private func setBottomLane() {
        node.position.y = -579
        node.physicsBody?.contactTestBitMask = Constants.carBottomLaneContact
        node.physicsBody?.categoryBitMask = Constants.carBottomLaneCategory
        node.zPosition = 6
    }
    
    private func physicsSetup() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 240.3, height: 102.6))
        body.isDynamic = true
        body.affectedByGravity = false
        body.collisionBitMask = Constants.carCollision
        node.physicsBody = body
    }
    
    private func startAnimation() {
        guard let carTexture = carTextures.shuffled().first else { return }
        var textures = [SKTexture]()
        textures.append(SKTexture(imageNamed: carTexture + "_frame_1"))
        textures.append(SKTexture(imageNamed: carTexture + "_frame_2"))
        textures.append(SKTexture(imageNamed: carTexture + "_frame_3"))
        textures.append(SKTexture(imageNamed: carTexture + "_frame_4"))
        textures.append(SKTexture(imageNamed: carTexture + "_frame_5"))
        textures.append(SKTexture(imageNamed: carTexture + "_frame_6"))
        textures.append(SKTexture(imageNamed: carTexture + "_frame_7"))
        textures.append(SKTexture(imageNamed: carTexture + "_frame_8"))
        
        let frames = SKAction.animate(with: textures, timePerFrame: 0.1, resize: false, restore: false)
        let repeatAnim = SKAction.repeatForever(frames)
        node.run(repeatAnim)
    }
}
