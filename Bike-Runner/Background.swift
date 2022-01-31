//
//  Background.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import Foundation
import SpriteKit

class Background {
    
    private var node: SKSpriteNode
    private var position: CGPoint
    var animIsPlaying: Bool
    
    init(node : SKSpriteNode) {
        self.node = node
        self.position = node.position
        self.animIsPlaying = true
        startAnimation()
    }
    
    func stopAnimation() {
        node.removeAllActions()
    }
    
    func startAnimation() {
        
            var textures = [SKTexture]()
            textures.append(SKTexture(imageNamed: "Layer 1"))
            textures.append(SKTexture(imageNamed: "Layer 2"))
            textures.append(SKTexture(imageNamed: "Layer 3"))
            textures.append(SKTexture(imageNamed: "Layer 4"))
            textures.append(SKTexture(imageNamed: "Layer 5"))
            textures.append(SKTexture(imageNamed: "Layer 6"))
            textures.append(SKTexture(imageNamed: "Layer 7"))
            textures.append(SKTexture(imageNamed: "Layer 8"))
            textures.append(SKTexture(imageNamed: "Layer 9"))
            textures.append(SKTexture(imageNamed: "Layer 10"))
            textures.append(SKTexture(imageNamed: "Layer 11"))
            textures.append(SKTexture(imageNamed: "Layer 12"))
            textures.append(SKTexture(imageNamed: "Layer 13"))
            textures.append(SKTexture(imageNamed: "Layer 14"))
            textures.append(SKTexture(imageNamed: "Layer 15"))
            textures.append(SKTexture(imageNamed: "Layer 16"))
            textures.append(SKTexture(imageNamed: "Layer 17"))
            
            let frames = SKAction.animate(with: textures, timePerFrame: 0.1, resize: false, restore: false)
            let repeatAnim = SKAction.repeatForever(frames)
            node.run(repeatAnim)
            
    }
}
