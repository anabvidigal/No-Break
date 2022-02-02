//
//  CarSpawner.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 01/02/22.
//

import Foundation
import SpriteKit

class CarSpawner {
    
    private var carNode: SKSpriteNode
    private var parent: SKNode
    private var cars: [Car] = []
    
    private var interval: TimeInterval = 1
    private var currentTime: TimeInterval = 0
    
    private let lanesHeights: [CGFloat] = [-533, -571]
    
    
    init(carNode: SKSpriteNode, parent: SKNode) {
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
            car.node.position.x -= GameManager.speed * deltaTime * cos(Constants.roadAngle * .pi / 180) * car.carSpeed
            car.node.position.y -= GameManager.speed * deltaTime * sin(Constants.roadAngle * .pi / 180) * car.carSpeed
        }
        
        // removing
        if let firstCar = cars.first {
            if firstCar.node.position.x < -900 {
                firstCar.node.removeFromParent()
                cars.removeFirst()
            }
        }
    }
    
    func spawn() {
        let new = Car(node: carNode)
        let randomLane = Car.Lane.allCases.randomElement()!
        new.setLane(randomLane)
        parent.addChild(new.node)
        cars.append(new)
    }
    
    func reset() {
        for car in cars {
            car.node.removeFromParent()
        }
        cars.removeAll()
        currentTime = interval
    }
}
