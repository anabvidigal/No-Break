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
    
    lazy var skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.alpha = 0
        return view
    }()
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recomeçar", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(restartClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func restartClicked() {
        gameScene?.reset()
        testView.alpha = 0
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func backClicked() {
        dismiss(animated: false)
    }
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(52)
        label.textColor = .green
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
        
        view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(300)
        }
        
        testView.addSubview(restartButton)
        restartButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        testView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(restartButton.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        testView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
                
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                gameScene = scene
                scene.scaleMode = .aspectFit
                scene.gameDelegate = self
                
                // Present the scene
                skView.presentScene(scene)
            }
            
            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true

        }
    

    func gameIsOver(_ sender: GameScene) {
        testView.alpha = 1
        scoreLabel.text = "Score: \(sender.scoreDetector.score)"
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        // added return landscape
        return .landscapeLeft
        
        // commented out the original content
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
