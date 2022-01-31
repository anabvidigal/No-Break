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

    func update (deltaTime: TimeInterval) {        
        for (index, node) in nodes.enumerated() {
            // move
            node.position.x -= GameManager.speed * deltaTime * CGFloat(index+1) * Constants.backgroundSpeed
            
            // chão infinito
            if node.position.x <= Constants.gameSceneLeftEdge {
                node.position.x = Constants.gameSceneRightEdge
            }
        }
    }
}
