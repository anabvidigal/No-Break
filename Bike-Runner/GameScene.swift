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
    var scenery: Scenery!
    var spawner: CarSpawner!
    var scoreDetector: ScoreDetector!
    
    var gameOverNode: SKSpriteNode!
    
    var lastUpdate = TimeInterval(0)
    var status: GameStatus = .playing
    
    var scoreLabel: SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        let playerNode = self.childNode(withName: "biker") as! SKSpriteNode
        player = Player(node: playerNode)
        player.startAnimation()
        
        let backgroundNodes = [
            self.childNode(withName: "background1") as! SKSpriteNode,
            self.childNode(withName: "background2") as! SKSpriteNode,
            self.childNode(withName: "background3") as! SKSpriteNode,
            self.childNode(withName: "background4") as! SKSpriteNode,
            self.childNode(withName: "background5") as! SKSpriteNode,
            self.childNode(withName: "road") as! SKSpriteNode,
            self.childNode(withName: "foreground") as! SKSpriteNode
        ]
        scenery = Scenery(nodes: backgroundNodes)
        
        let carNode = childNode(withName: "car") as! SKSpriteNode
        spawner = CarSpawner(carNode: carNode, parent: self)
        
        // score
        let scoreNode = player.node.childNode(withName: "bikerScoreDetector")!
        scoreDetector = ScoreDetector(node: scoreNode)
        
        // label
        scoreLabel = childNode(withName: "scoreUpdateLabel") as? SKLabelNode
        
        
        // game over
        gameOverNode = childNode(withName: "gameOver") as? SKSpriteNode
        gameOverNode.removeFromParent()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch status {
        case .playing:
            player.changeLane()
        case .gameOver:
            break
        }
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
        scenery.update(deltaTime: deltaTime)
        spawner.update(deltaTime: deltaTime)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // if player contacts car, game over; if scorer contacts car, add score
        
        if contact.bodyA == scoreDetector.node.physicsBody {
            scoreDetector.incrementScore()
            scoreLabel.text = "\(scoreDetector.score)"
        } else {
            status = .gameOver
            gameOver()
        }
    }
    
    func gameOver() {
        addChild(gameOverNode)
        player.die()
    }
    
    func gameScore() {
        
    }
    
}

enum GameStatus {
    case playing
    case gameOver
}
