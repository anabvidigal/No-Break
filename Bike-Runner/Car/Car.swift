//
//  Car.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 01/02/22.
//

import Foundation
import SpriteKit

class Car {
    
    var carSpeed: CGFloat = .random(in: 1.9...2.2)
    var node: SKNode
    private var carTextures = [
        "car",
        "rounded_car",
        "jeep",
        "super_car",
        "kombi"
    ]
    
    private static var carTexturesAnimationMap: [String: [SKTexture]] = [
        "car": [
            SKTexture(imageNamed: "car_frame_1"),
            SKTexture(imageNamed: "car_frame_2"),
            SKTexture(imageNamed: "car_frame_3"),
            SKTexture(imageNamed: "car_frame_4"),
            SKTexture(imageNamed: "car_frame_5"),
            SKTexture(imageNamed: "car_frame_6"),
            SKTexture(imageNamed: "car_frame_7"),
            SKTexture(imageNamed: "car_frame_8")
        ],
        "rounded_car": [
            SKTexture(imageNamed: "rounded_car_frame_1"),
            SKTexture(imageNamed: "rounded_car_frame_2"),
            SKTexture(imageNamed: "rounded_car_frame_3"),
            SKTexture(imageNamed: "rounded_car_frame_4"),
            SKTexture(imageNamed: "rounded_car_frame_5"),
            SKTexture(imageNamed: "rounded_car_frame_6"),
            SKTexture(imageNamed: "rounded_car_frame_7"),
            SKTexture(imageNamed: "rounded_car_frame_8")
        ],
        "jeep": [
            SKTexture(imageNamed: "jeep_frame_1"),
            SKTexture(imageNamed: "jeep_frame_2"),
            SKTexture(imageNamed: "jeep_frame_3"),
            SKTexture(imageNamed: "jeep_frame_4"),
            SKTexture(imageNamed: "jeep_frame_5"),
            SKTexture(imageNamed: "jeep_frame_6"),
            SKTexture(imageNamed: "jeep_frame_7"),
            SKTexture(imageNamed: "jeep_frame_8")
        ],
        "super_car": [
            SKTexture(imageNamed: "super_car_frame_1"),
            SKTexture(imageNamed: "super_car_frame_2"),
            SKTexture(imageNamed: "super_car_frame_3"),
            SKTexture(imageNamed: "super_car_frame_4"),
            SKTexture(imageNamed: "super_car_frame_5"),
            SKTexture(imageNamed: "super_car_frame_6"),
            SKTexture(imageNamed: "super_car_frame_7"),
            SKTexture(imageNamed: "super_car_frame_8")
        ],
        "kombi": [
            SKTexture(imageNamed: "kombi_frame_1"),
            SKTexture(imageNamed: "kombi_frame_2"),
            SKTexture(imageNamed: "kombi_frame_3"),
            SKTexture(imageNamed: "kombi_frame_4"),
            SKTexture(imageNamed: "kombi_frame_5"),
            SKTexture(imageNamed: "kombi_frame_6"),
            SKTexture(imageNamed: "kombi_frame_7"),
            SKTexture(imageNamed: "kombi_frame_8")
        ]
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
        let textures = Car.carTexturesAnimationMap[carTexture]!
        
        let frames = SKAction.animate(with: textures, timePerFrame: 0.1, resize: false, restore: false)
        let repeatAnim = SKAction.repeatForever(frames)
        node.run(repeatAnim)
    }
}
