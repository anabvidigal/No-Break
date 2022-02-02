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
        "police",
        "rounded_green",
        "convertible",
        "rounded_red",
        "taxi"
    ]
    
    init(node: SKSpriteNode) {
        self.node = node.copy() as! SKSpriteNode
        node.texture = SKTexture.init(imageNamed: carTextures.shuffled().first!)
        physicsSetup()
        
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
    
    func setTopLane() {
        node.position.y = -533
        node.physicsBody?.contactTestBitMask = Constants.carTopLaneContact
        node.physicsBody?.categoryBitMask = Constants.carTopLaneCategory
        node.zPosition = 1
    }
    
    func setBottomLane() {
        node.position.y = -571
        node.physicsBody?.contactTestBitMask = Constants.carBottomLaneContact
        node.physicsBody?.categoryBitMask = Constants.carBottomLaneCategory
        node.zPosition = 6
    }
    
    func physicsSetup() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 240.3, height: 102.6))
        body.isDynamic = true
        body.affectedByGravity = false
        body.collisionBitMask = Constants.carCollision
        node.physicsBody = body
    }
    
    
    enum Lane: CaseIterable {
        case topLane
        case bottomLane
    }
}


