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
    private var scenery: Scenery!
    private var carSpawner: CarSpawner!
    var speedManager = SpeedManager()
    private var coinSpawner: CoinSpawner!
    var introNode: SKSpriteNode!
    
    private var gameCenter = GameCenter()
    var highscoreManager = HighscoreManager(repository: UserDefaultsHighScoreRepository())
    
    var coinManager: CoinManager = CoinManager(coinsRepository: UserDefaultsCoinsRepository())
    var scoreDetector: ScoreDetector!
    var status: GameStatus = .animating
    var lastUpdate = TimeInterval(0)
    var isHighscore = false
    var bikerManager: BikerManager!
    
    weak var gameDelegate: GameSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        // intro
        introNode = childNode(withName: "intro") as? SKSpriteNode
        introNode.removeFromParent()
        
        // player
        let playerNode = self.childNode(withName: "biker") as! SKSpriteNode
        player = Player(node: playerNode, speedManager: speedManager, biker: bikerManager.selectedBiker)
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
        
        gameDelegate?.setHighscore(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch status {
        case .animating:
            break
        case .intro:
            status = .playing
            player.changeLane()
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
            catchCoin()
        } else {
            gameOver()
        }
    }
    
    private func score() {
        scoreDetector.incrementScore()
        gameDelegate?.score(self)
    }
    
    private func catchCoin() {
        coinSpawner.removeCoin()
        coinManager.incrementCoins()
        gameDelegate?.catchCoin(self)
    }
    
    private func gameOver() {
        status = .gameOver
        player.die()
        carSpawner.stopCarsAnimation()
        gameCenter.submitScore(score: scoreDetector.score)
        isHighscore = highscoreManager.setIfHighscore(for: scoreDetector.score)
        gameDelegate?.gameIsOver(self)
    }
    
    func reset(){
        status = .intro
        carSpawner.reset()
        player.reset()
        scoreDetector.resetScore()
        speedManager.resetSpeed()
        coinSpawner.reset()
        coinManager.addCoins()
        gameDelegate?.reset()
        addChild(introNode)
    }
}


enum GameStatus {
    case animating
    case intro
    case playing
    case gameOver
}
