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
    private var scoreDetector: ScoreDetector!
    var introNode: SKSpriteNode!
    
    private var scenery: Scenery?
    private var carSpawner: CarSpawner?
    private var coinSpawner: CoinSpawner?
    var speedManager = SpeedManager()
    
    
    var gameCenter: GameCenter?
    var scoreManager: ScoreManager?
    var coinManager: CoinManager?
    var bikerManager: BikerManager?
    
    
    var status: GameStatus = .animating
    var lastUpdate = TimeInterval(0)
    
    
    weak var gameDelegate: GameSceneDelegate?
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        introNode = childNode(withName: "intro") as? SKSpriteNode
        introNode.removeFromParent()
        
        let playerNode = self.childNode(withName: "biker") as! SKSpriteNode
        if let biker = bikerManager?.getSelectedBiker() {
            player = Player(node: playerNode, speedManager: speedManager, biker: biker)
            player.startAnimation()
        }
        
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
        
        let carNode = childNode(withName: "car") as! SKSpriteNode
        carSpawner = CarSpawner(carNode: carNode, parent: self, speedManager: speedManager)
        
        let coinNode = carNode.childNode(withName: "coin") as! SKSpriteNode
        coinSpawner = CoinSpawner(coinNode: coinNode)
        
        let scoreNode = player.node.childNode(withName: "bikerScoreDetector")!
        scoreDetector = ScoreDetector(node: scoreNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch status {
        case .animating:
            break
        case .intro:
            introTouched()
        case .playing:
            player.changeLane()
        case .gameOver:
            break
        }
    }
    
    private func introTouched() {
        status = .playing
        player.changeLane()
        introNode.removeFromParent()
        gameDelegate?.showStats()
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
        case .intro:
            introUpdate(deltaTime: deltaTime)
        case .playing:
            playingUpdate(deltaTime: deltaTime)
        case .gameOver:
            break
        }
    }
    
    func introUpdate(deltaTime: TimeInterval) {
        scenery?.update(deltaTime: deltaTime)
    }
    
    func playingUpdate(deltaTime: TimeInterval) {
        scenery?.update(deltaTime: deltaTime)
        carSpawner?.update(deltaTime: deltaTime, coinSpawner: coinSpawner)
        speedManager.update(deltaTime: deltaTime)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // if player contacts car, game over; if scorer contacts car, add score
        
        if contact.bodyA == scoreDetector.node.physicsBody {
            score()
        } else if contact.bodyB == coinSpawner?.coins.first?.node.physicsBody {
            catchCoin()
        } else {
            gameOver()
        }
    }
    
    private func score() {
        scoreManager?.incrementScore()
        gameDelegate?.score(self)
    }
    
    private func catchCoin() {
        if let coin = coinSpawner?.coins.first {
            coin.node.physicsBody?.velocity = CGVector(dx: 100, dy:1000)
        }
        coinManager?.incrementCoins()
        gameDelegate?.catchCoin(self)
        score()
        playSound(sound: "coin", type: "wav")
    }
    
    private func gameOver() {
        status = .gameOver
        player.die()
        playSound(sound: "player-die", type: "wav")
        carSpawner?.stopCarsAnimation()
        scoreManager?.setHighscore()
        gameDelegate?.gameIsOver(self)
    }
    
    func reset() {
        gameCenter?.submitScore(score: scoreManager?.currentScore ?? 0)
        status = .intro
        carSpawner?.reset()
        player.reset()
        coinSpawner?.reset()
        scoreManager?.resetScore()
        speedManager.resetSpeed()
        coinManager?.resetCollectedCoins()
        gameDelegate?.reset()
        addChild(introNode)
    }
    
    func continueGame() {
        addChild(introNode)
        status = .intro
        carSpawner?.reset()
        coinSpawner?.reset()
        player.reset()
    }
}


enum GameStatus {
    case animating
    case intro
    case playing
    case gameOver
}
