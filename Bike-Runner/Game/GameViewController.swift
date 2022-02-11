//
//  GameViewController.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import UIKit
import SpriteKit
import GameplayKit
import SnapKit
import GameKit

protocol GameSceneDelegate: AnyObject {
    func gameIsOver(_ sender: GameScene)
}

class GameViewController: UIViewController, GameSceneDelegate {

    var gameScene: GameScene?
    var gameCenter = GameCenter()
    
    lazy var skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var homeView: HomeView = {
        let view = HomeView(parent: self)
        return view
    }()
    
    lazy var gameStatsView: GameStatsView = {
        let view = GameStatsView(parent: self)
        view.alpha = 0
        return view
    }()
    
    lazy var gameOverView: GameOverView = {
        let view = GameOverView(parent: self)
        view.alpha = 0
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene{
            scene.lastUpdate = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBrown1
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        setupSkView()
        setupHomeView()
        setupGameStatsView()
        setupGameOverView()
    
        gameCenter.authenticateUser(self)
                
        
    }
    
    private func setupSkView() {
        view.addSubview(skView)
        skView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupScene()
    }
    
    private func setupScene() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            gameScene = scene
            scene.scaleMode = .aspectFit
            scene.gameDelegate = self
            skView.presentScene(scene)
        }
        skView.ignoresSiblingOrder = true
    }
    
    private func setupHomeView() {
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupGameStatsView() {
        view.addSubview(gameStatsView)
        gameStatsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setupGameOverView() {
        view.addSubview(gameOverView)
        gameOverView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(300)
        }
    }

    func gameIsOver(_ sender: GameScene) {
        gameOverView.alpha = 1
        gameOverView.scoreLabel.text = "Score: \(sender.scoreDetector.score)"
        gameOverView.highscoreLabel.alpha = sender.isHighscore ? 1 : 0
        gameOverView.updateCoinsStackConstrainsIf(isHighScore: sender.isHighscore)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
