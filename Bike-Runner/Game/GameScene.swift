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
    
    private var player: Player!
    private var scenery: Scenery!
    private var carSpawner: CarSpawner!
    private var speedManager: SpeedManager = SpeedManager()
    private var coinSpawner: CoinSpawner!
    var introNode: SKSpriteNode!
    private var scoreLabel: SKLabelNode!
    
    private var gameCenter = GameCenter()
    
    var coinManager: CoinManager = CoinManager()
    var scoreDetector: ScoreDetector!
    var status: GameStatus = .animating
    var lastUpdate = TimeInterval(0)
    
    weak var gameDelegate: GameSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        // intro
        introNode = childNode(withName: "intro") as? SKSpriteNode
        introNode.removeFromParent()
        
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
        
//         coin
        let coinNode = carNode.childNode(withName: "coin") as! SKSpriteNode
        coinSpawner = CoinSpawner(coinNode: coinNode)
        
        // score
        let scoreNode = player.node.childNode(withName: "bikerScoreDetector")!
        scoreDetector = ScoreDetector(node: scoreNode, gameCenter: gameCenter)
        
        // label
        scoreLabel = childNode(withName: "scoreUpdateLabel") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch status {
        case .animating:
            break
        case .intro:
            status = .playing
            introNode.removeFromParent()
            speedManager.resetSpeed()
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
            speedManager.resetSpeed()
            return
        }
        
        let deltaTime = currentTime - lastUpdate
        lastUpdate = currentTime
        
        switch status {
        case .animating:
            introUpdate(deltaTime: deltaTime)
            speedManager.resetSpeed()
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
            score()
        } else if contact.bodyB == coinSpawner.coins.first?.node.physicsBody {
            coinSpawner.removeCoin()
            coinManager.incrementCoins()
            print(coinManager.coins)
        } else {
            status = .gameOver
            gameOver()
        }
    }
    
    private func gameOver() {
        player.die()
        carSpawner.stopCarsAnimation()
        gameDelegate?.gameIsOver(self)
        submitGameCenterScore()
    }
    
    private func score() {
        scoreDetector.incrementScore()
        scoreLabel.text = "\(scoreDetector.score)"
    }
    
    private func submitGameCenterScore() {
        gameCenter.submitScore(score: scoreDetector.score)
    }
    
    func reset(){
        status = .intro
        carSpawner.reset()
        player.reset()
        scoreDetector.resetScore()
        scoreLabel.text = "0"
        speedManager.resetSpeed()
        coinSpawner.reset()
        coinManager.resetCoins()
        addChild(introNode)
    }
}


enum GameStatus {
    case animating
    case intro
    case playing
    case gameOver
}
