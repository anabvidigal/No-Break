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
    
    lazy var homeView: UIView = {
        let view = HomeView(parent: self)
        return view
    }()
    
    lazy var gameOverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBrown2
        view.layer.borderColor = UIColor.appBrown1.cgColor
        view.layer.borderWidth = 8
        view.alpha = 0
        return view
    }()
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restart", for: .normal)
        button.titleLabel?.font = .kenneyFont.withSize(40)
        button.addTarget(self, action: #selector(restartClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func restartClicked() {
        gameScene?.reset()
        gameOverView.alpha = 0
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home", for: .normal)
        button.titleLabel?.font = .kenneyFont.withSize(20)
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func backClicked() {
        gameScene?.reset()
        gameScene?.status = .animating
        gameScene?.introNode.removeFromParent()
        homeView.alpha = 1
        gameOverView.alpha = 0
    }
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(52)
        label.textColor = .appBeige
        label.textAlignment = .center
        return label
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
        
        // added landscape orientation
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        view.addSubview(skView)
        skView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupHomeView()
        
        setupGameOverView()
        setupRestartButton()
        setupBackButton()
        setupScoreLabel()
    
        gameCenter.authenticateUser(self)
                
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            // Set the scale mode to scale to fit the window
            gameScene = scene
            scene.scaleMode = .aspectFit
            scene.gameDelegate = self
            skView.presentScene(scene)
        }
        
        skView.ignoresSiblingOrder = true
//        skView.showsFPS = true
//        skView.showsNodeCount = true
    }
    
    private func setupHomeView() {
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    
    private func setupRestartButton() {
        gameOverView.addSubview(restartButton)
        restartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    private func setupBackButton() {
        gameOverView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupScoreLabel() {
        gameOverView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
    }

    func gameIsOver(_ sender: GameScene) {
        gameOverView.alpha = 1
        scoreLabel.text = "Score: \(sender.scoreDetector.score)"
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
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
