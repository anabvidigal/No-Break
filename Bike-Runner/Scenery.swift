//
//  Background.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import Foundation
import SpriteKit

class Scenery {
    
    private var nodes: [SKNode]
    private var initialPositions: [CGPoint] = []
    private var speedManager: SpeedManager

    init(nodes: [SKNode], speedManager: SpeedManager) {
        self.nodes = nodes
        self.speedManager = speedManager
        
        for node in nodes {
            node.zRotation += Constants.roadAngle * .pi / 180
            initialPositions.append(node.position)
        }
    }

    func update (deltaTime: TimeInterval) {        
        for (index, node) in nodes.enumerated() {
            // move
            node.position.x -= speedManager.speed * deltaTime * CGFloat(index+1) * Constants.scenerySpeed * cos(Constants.roadAngle * .pi / 180)
            node.position.y -= speedManager.speed * deltaTime * CGFloat(index+1) * Constants.scenerySpeed * sin(Constants.roadAngle * .pi / 180)
            
            // chão infinito
            if node.position.x <= Constants.gameSceneLeftEdge * cos(Constants.roadAngle * .pi / 180) {
                node.position.x = Constants.gameSceneRightEdge * cos(Constants.roadAngle * .pi / 180)
                node.position.y = initialPositions[index].y + 8
            }
        }
    }
}
