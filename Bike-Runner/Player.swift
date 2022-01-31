//
//  Player.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import Foundation
import SpriteKit

class Player {
    
    private var node: SKSpriteNode
    private var startPosition: CGPoint
    
    var status: LaneBikeStatus = .topLane

    
    init(node: SKSpriteNode) {
        self.node = node
        self.startPosition = node.position
        status = .topLane
    }
    
    func changeLane() {
        
        switch status {
        case .topLane:
            node.position.y = -243
            status = .bottomLane
            node.zPosition = 0
        case .bottomLane:
            node.position.y = -185
            status = .topLane
            node.zPosition = 5
        }
    }
    
    func die() {
        node.yScale = -0.4
    }
        
}
    
enum LaneBikeStatus {
    case topLane
    case bottomLane
}
