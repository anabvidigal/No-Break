//
//  GameManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import SpriteKit

class SpeedManager {
    
    private var interval: TimeInterval = 0.1
    private var currentTime: TimeInterval = 0
    var speed: CGFloat = 400
    
    func update(deltaTime: TimeInterval) {
        
        currentTime += deltaTime
        
        if currentTime > interval {
            currentTime -= interval
            incrementSpeed()
        }
        
    }
    
    func incrementSpeed() {
        speed += 1
    }
    
    func resetSpeed() {
        speed = 400
    }
    
}
