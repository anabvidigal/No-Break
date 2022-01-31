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
        
        let backgroundNode = self.childNode(withName: "background") as! SKSpriteNode
        background = Background(node: backgroundNode)
        
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
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        status = .gameOver
        gameOver()
    }
    
    func gameOver() {
        addChild(gameOverNode)
        player.die()
        car.die()
        background.stopAnimation()
    }
    
}

enum GameStatus {
    case playing
    case gameOver
}
