//
//  GameScene.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var background: Background!
    var car: CarManager!
    
    var gameOverNode: SKSpriteNode!
    
    var lastUpdate = TimeInterval(0)
    var status: GameStatus = .playing
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        let playerNode = self.childNode(withName: "biker") as! SKSpriteNode
        player = Player(node: playerNode)
        player.startAnimation()
        
        
        let backgroundNodes = [
            self.childNode(withName: "background2") as! SKSpriteNode,
            self.childNode(withName: "background12") as! SKSpriteNode,
            self.childNode(withName: "background1") as! SKSpriteNode,
            self.childNode(withName: "background3") as! SKSpriteNode,
            self.childNode(withName: "background4") as! SKSpriteNode,
            self.childNode(withName: "background5") as! SKSpriteNode
        ]
        
        background = Background(nodes: backgroundNodes)
        
        let carNode = self.childNode(withName: "car") as! SKSpriteNode
        car = CarManager(node: carNode)
                
        
        // game over
        gameOverNode = childNode(withName: "gameOver") as? SKSpriteNode
        gameOverNode.removeFromParent()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.changeLane()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if lastUpdate == 0 {
            lastUpdate = currentTime
            return
        }
        
        let deltaTime = currentTime - lastUpdate
        lastUpdate = currentTime
        
        
        switch status {
        case .playing:
            playingUpdate(deltaTime: deltaTime)
        case .gameOver:
            break
        }
    }
    
    
    func playingUpdate(deltaTime: TimeInterval) {
        car.update(deltaTime: deltaTime)
        background.update(deltaTime: deltaTime)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("bodyA bitmask: ", contact.bodyA.contactTestBitMask)
        print("bodyB bitmask: ", contact.bodyB.contactTestBitMask)
        status = .gameOver
        gameOver()
        
    }
    
    func gameOver() {
        addChild(gameOverNode)
        player.die()
        car.die()
        background.stopAnimation()
    }
    
    func gameScore() {
        
    }
    
}

enum GameStatus {
    case playing
    case gameOver
}
