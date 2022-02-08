//
//  GameScene.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import SpriteKit
import GameplayKit
import GameKit
import SnapKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var scenery: Scenery!
    var carSpawner: CarSpawner!
    var scoreDetector: ScoreDetector!
    var speedManager: SpeedManager = SpeedManager()
    var coinSpawner: CoinSpawner!
    var coinManager: CoinManager = CoinManager()
    
    var gameCenter = GameCenter()
    
    var gameOverNode: SKSpriteNode!
    var introNode: SKSpriteNode!
    var finalScoreNode: SKLabelNode!
    
    var lastUpdate = TimeInterval(0)
    var status: GameStatus = .intro
    
    var scoreLabel: SKLabelNode!
    
    var viewLeaderboardNode: SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        // intro
        introNode = childNode(withName: "intro") as? SKSpriteNode
        
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
        
        // car
        let carNode = childNode(withName: "car") as! SKSpriteNode
        carSpawner = CarSpawner(carNode: carNode, parent: self, speedManager: speedManager)
        
        // coin
        let coinNode = carNode.childNode(withName: "coin") as! SKSpriteNode
        coinSpawner = CoinSpawner(coinNode: coinNode)
        
        // score
        let scoreNode = player.node.childNode(withName: "bikerScoreDetector")!
        scoreDetector = ScoreDetector(node: scoreNode)
        
        // label
        scoreLabel = childNode(withName: "scoreUpdateLabel") as? SKLabelNode
        
        // game over
        gameOverNode = childNode(withName: "gameover") as? SKSpriteNode
        gameOverNode.removeFromParent()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch status {
        case .intro:
            status = .playing
            introNode.removeFromParent()
            speedManager.resetSpeed()
        case .playing:
            player.changeLane()
        case .gameOver:
            reset()
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lastUpdate == 0 {
            lastUpdate = currentTime
            speedManager.resetSpeed()
            return
        }
        
        let deltaTime = currentTime - lastUpdate
        lastUpdate = currentTime
        
        switch status {
        case .intro:
            introUpdate(deltaTime: deltaTime)
            speedManager.resetSpeed()
        case .playing:
            playingUpdate(deltaTime: deltaTime)
        case .gameOver:
            break
        }
    }
    
    func introUpdate(deltaTime: TimeInterval) {
        scenery.update(deltaTime: deltaTime)
    }
    
    func playingUpdate(deltaTime: TimeInterval) {
        scenery.update(deltaTime: deltaTime)
        carSpawner.update(deltaTime: deltaTime, coinSpawner: coinSpawner)
        speedManager.update(deltaTime: deltaTime)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // if player contacts car, game over; if scorer contacts car, add score
        
        if contact.bodyA == scoreDetector.node.physicsBody {
            gameScore()
        } else if contact.bodyB == coinSpawner.coins.first?.node.physicsBody {
            coinSpawner.removeCoin()
            coinManager.incrementCoins()
            print(coinManager.coins)
        } else {
            status = .gameOver
            gameOver()
        }
    }
    
    func gameOver() {
        addChild(gameOverNode)
//      addChild(leaderboardNode)
//      addChild(playAgainNode)
        displayFinalScore()
        submitGameCenterScore()
        player.die()
        carSpawner.stopCars()
    }
    
    func gameScore() {
        scoreDetector.incrementScore()
        scoreLabel.text = "\(scoreDetector.score)"
    }
    
    func displayFinalScore() {
        finalScoreNode.text = "FINAL SCORE: " + "\(scoreDetector.score)"
        addChild(finalScoreNode)
    }
    
    func submitGameCenterScore() {
        gameCenter.submitScore(score: scoreDetector.score)
    }
    
    func reset(){
        gameOverNode.removeFromParent()
        finalScoreNode.removeFromParent()
        status = .playing
        carSpawner.reset()
        player.reset()
        scoreDetector.resetScore()
        scoreLabel.text = "0"
        speedManager.resetSpeed()
        coinSpawner.reset()
        coinManager.resetCoins()
    }
}


enum GameStatus {
    case intro
    case playing
    case gameOver
}
