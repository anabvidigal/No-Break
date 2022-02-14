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
    func setHighscore(_ sender: GameScene)
    func score(_ sender: GameScene)
    func catchCoin(_ sender: GameScene)
    func reset()
}

class GameViewController: UIViewController, GameSceneDelegate {

    var gameScene: GameScene?
    var gameCenter = GameCenter()
    var bikersRepository: BikersRepository
    
    lazy var skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsTransparency = true
        return view
    }()
    
    lazy var homeView: HomeView = {
        let view = HomeView(parent: self)
        return view
    }()
    
    lazy var scoreView: ScoreView = {
        let view = ScoreView(parent: self)
        view.alpha = 0
        return view
    }()
    
    lazy var coinsView: CoinsView = {
        let view = CoinsView(parent: self)
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
    
    init(bikersRepository: BikersRepository) {
        self.bikersRepository = bikersRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBrown1
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        setupSkView()
        setupHomeView()
        setupScoreView()
        setupCoinsView()
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
            scene.scaleMode = .aspectFill
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
    
    private func setupScoreView() {
        view.addSubview(scoreView)
        scoreView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setupCoinsView() {
        view.addSubview(coinsView)
        coinsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
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
        gameOverView.coinsLabel.text = "Coins: \(sender.coinManager.playerCoins)"
        gameOverView.collectedCoinsLabel.text = "+\(sender.coinManager.collectedCoins)"
        gameOverView.updateCoinsStackConstrainsIf(isHighScore: sender.isHighscore)
    }
    
    func score(_ sender: GameScene) {
        scoreView.scoreLabel.text = "\(sender.scoreDetector.score)"
        if sender.scoreDetector.score > sender.highscoreManager.highscore {
            scoreView.highscoreLabel.text = "\(sender.scoreDetector.score)"
        }
    }
    
    func catchCoin(_ sender: GameScene) {
        coinsView.coinsLabel.text = "\(sender.coinManager.collectedCoins)"
    }
    
    func setHighscore(_ sender: GameScene) {
        scoreView.highscoreLabel.text = "\(sender.highscoreManager.highscore)"
    }
    
    func reset() {
        scoreView.scoreLabel.text = "0"
        coinsView.coinsLabel.text = "0"
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
