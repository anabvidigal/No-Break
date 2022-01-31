//
//  Road.swift
//  Bike-Runner
//
//  Created by André Schueda on 31/01/22.
//

import Foundation
import SpriteKit

class Road {
    
    private var nodes: [SKNode]
    private var initialPositions: [CGPoint] = []
    
    init(nodes: [SKNode]) {
        self.nodes = nodes
        
        for node in nodes {
            initialPositions.append(node.position)
        }
    }
    
    func update (deltaTime: TimeInterval) {
        
        for (index, node) in nodes.enumerated() {
            // move
            node.position.x -= GameManager.speed * deltaTime * CGFloat(index+1) * cos(-20 * .pi / 180)
            node.position.y -= GameManager.speed * deltaTime * CGFloat(index+1) * sin(-20 * .pi / 180)

            
            // chão infinito
            if node.position.x <= initialPositions[index].x - 256 * cos(-20 * .pi / 180) {
                node.position.x = initialPositions[index].x
                node.position.y = initialPositions[index].y
            }
        }
    }
}
