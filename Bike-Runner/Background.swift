//
//  Background.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import Foundation
import SpriteKit

class Background {
    
    private var nodes: [SKNode]
    
    init(nodes: [SKNode]) {
        self.nodes = nodes
        
    }
    
    func stopAnimation() {
        print("oi")
    }
    
    func update (deltaTime: TimeInterval) {
        
        for (index, node) in nodes.enumerated() {
            // move
            node.position.x -= GameManager.speed * deltaTime * CGFloat(index+1) * 0.3
            
            // chão infinito
            if node.position.x <= -768 {
                node.position.x = 768
            }
        }
    }
}
