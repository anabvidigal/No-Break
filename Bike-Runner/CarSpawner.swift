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
    private var speedManager: SpeedManager!

    
    private var interval: TimeInterval = 1
    private var currentTime: TimeInterval = 0
    
    init(carNode: SKSpriteNode, parent: SKNode, speedManager: SpeedManager) {
        self.carNode = carNode
        self.parent = parent
        self.speedManager = speedManager
    }
    
    func update(deltaTime: TimeInterval) {
        
        currentTime += deltaTime
        
        if currentTime > interval {
            spawn()
            currentTime = 0
            interval = TimeInterval(Float.random(in: 0.7...1.3))
        }
        
        // movement
        for car in cars {
            car.node.position.x -= speedManager.speed * deltaTime * cos(Constants.roadAngle * .pi / 180) * car.carSpeed
            car.node.position.y -= speedManager.speed * deltaTime * sin(Constants.roadAngle * .pi / 180) * car.carSpeed
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
