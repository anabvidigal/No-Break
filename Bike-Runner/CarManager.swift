//
//  CarManager.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import Foundation
import SpriteKit

class CarManager {
    
    private var node: SKSpriteNode
    
    private let interval = TimeInterval(4)
    private var currentTime = TimeInterval(0)
    
    init(node: SKSpriteNode) {
        self.node = node
        currentTime = interval
    }
    
    func update(deltaTime: TimeInterval) {
        
        currentTime += deltaTime
        
        if currentTime > interval {
            currentTime -= interval
        }
        
        node.position.x -= GameManager.speed * deltaTime
    }
    
    func die() {
        node.yScale = -0.9
    }
}
    


enum LaneCarStatus {
    case topLane
    case bottomLane
}

// bottom -257
// top -199
