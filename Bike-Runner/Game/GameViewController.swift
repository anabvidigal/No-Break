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

    private var gameScene: GameScene?
    private var gameCenter = GameCenter()
    
    lazy var skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var homeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        setHomeButton(title: "Play", action: #selector(playButtonClicked), button: button, fontSize: 40)
        return button
    }()
    @objc func playButtonClicked() {
        guard let introNode = gameScene?.introNode else { return }
        gameScene?.addChild(introNode)
        gameScene?.status = .intro
        homeStack.alpha = 0
    }
    
    lazy var leaderboardButton: UIButton = {
        let button = UIButton()
        setHomeButton(title: "Leaderboard", action: #selector(leaderboardButtonClicked), button: button, fontSize: 20)
        return button
    }()
    @objc func leaderboardButtonClicked() {
        let vc = GKGameCenterViewController.init(state: .leaderboards)
        vc.gameCenterDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    lazy var achievementsButton: UIButton = {
        let button = UIButton()
        setHomeButton(title: "Achievements", action: #selector(achievementsButtonClicked), button: button, fontSize: 20)
        return button
    }()
    @objc func achievementsButtonClicked() {
        let vc = GKGameCenterViewController(state: .achievements)
        vc.gameCenterDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    private func setHomeButton(title: String, action: Selector, button: UIButton, fontSize: CGFloat) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .kenneyFont.withSize(fontSize)
        button.setTitleColor(.appBeige, for: .normal)
        button.layer.borderColor = UIColor.appBrown1.cgColor
        button.layer.borderWidth = 4
        button.backgroundColor = .appBrown2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
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
        homeStack.alpha = 1
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
        
        // added landscape orientation
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        view.addSubview(skView)
        NSLayoutConstraint.activate([
            skView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skView.topAnchor.constraint(equalTo: view.topAnchor),
            skView.leftAnchor.constraint(equalTo: view.leftAnchor),
            skView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        setupHomeStack()
        
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
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
    
    private func setupHomeStack() {
        view.addSubview(homeStack)
        homeStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(UIScreen.main.bounds.height * 0.2))
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(480)
        }
        
        [
            leaderboardButton,
            playButton,
            achievementsButton
        ].forEach { homeStack.addArrangedSubview($0) }
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
