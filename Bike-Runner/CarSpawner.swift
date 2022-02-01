//
//  CarSpawner.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 01/02/22.
//

import Foundation
import SpriteKit

class CarSpawner {
    
    private var carNode: SKNode
    private var parent: SKNode
    private var cars: [SKNode] = []
    
    private var interval: TimeInterval = 1
    private var currentTime: TimeInterval = 0
    
    private let lanesHeights: [CGFloat] = [-533, -571]
    
    
    init(carNode: SKNode, parent: SKNode) {
        self.carNode = carNode
        self.parent = parent
    }
    
    func update(deltaTime: TimeInterval) {
        
        currentTime += deltaTime
        
        if currentTime > interval {
            spawn()
            currentTime = 0
            interval = TimeInterval(Float.random(in: 1.2...2.4))
        }
        
        // movement
        for car in cars {
            car.position.x -= GameManager.speed * deltaTime * cos(Constants.roadAngle * .pi / 180)
            car.position.y -= GameManager.speed * deltaTime * sin(Constants.roadAngle * .pi / 180)
        }
        
        // removing
        if let firstCar = cars.first {
            if firstCar.position.x < -800 {
                firstCar.removeFromParent()
                cars.removeFirst()
            }
        }
        
    }
    
    func spawn() {
        let new = carNode.copy() as! SKNode
        let index = Int.random(in: 0...1)
        
        new.position.y = lanesHeights[index]
        new.zPosition = index == 0 ? 1 : 6
        physicsSetup(node: new, index)
        parent.addChild(new)
        cars.append(new)
    }
    
    
    func physicsSetup(node: SKNode, _ index: Int) {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 240.3, height: 102.6))
        body.isDynamic = true
        body.affectedByGravity = false
        body.contactTestBitMask = index == 0 ? Constants.carTopLaneContact : Constants.carBottomLaneContact
        body.categoryBitMask = index == 0 ? Constants.carTopLaneCategory : Constants.carBottomLaneCategory
        body.collisionBitMask = Constants.carCollision
        node.physicsBody = body
    }
    
    
    func reset() {
        for car in cars {
            car.removeFromParent()
        }
        cars.removeAll()
        currentTime = interval
    }
}
