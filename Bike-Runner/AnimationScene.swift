//
//  AnimationScene.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 02/02/22.
//

import Foundation
import SpriteKit

class AnimationScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var scenery: Scenery!
    var speedManager: SpeedManager!
        
    var lastUpdate = TimeInterval(0)
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        // speed manager
        speedManager = SpeedManager()
        
        // player
        let playerNode = self.childNode(withName: "biker") as! SKSpriteNode
        player = Player(node: playerNode, speedManager: speedManager)
        player.startAnimation()
        
        // bg
        let backgroundNodes = [
            self.childNode(withName: "background1") as! SKSpriteNode,
            self.childNode(withName: "background2") as! SKSpriteNode,
            self.childNode(withName: "background3") as! SKSpriteNode,
            self.childNode(withName: "background4") as! SKSpriteNode,
            self.childNode(withName: "background5") as! SKSpriteNode,
            self.childNode(withName: "road") as! SKSpriteNode,
            self.childNode(withName: "foreground") as! SKSpriteNode
        ]
        scenery = Scenery(nodes: backgroundNodes, speedManager: speedManager)
                
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lastUpdate == 0 {
            lastUpdate = currentTime
            return
        }
        
        let deltaTime = currentTime - lastUpdate
        lastUpdate = currentTime
        
        scenery.update(deltaTime: deltaTime)
        speedManager.update(deltaTime: deltaTime)

        }
    }





