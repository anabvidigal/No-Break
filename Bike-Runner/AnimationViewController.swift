//
//  AnimationViewController.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 02/02/22.
//


import UIKit
import SpriteKit
import GameplayKit
import GameKit

class AnimationViewController: UIViewController {
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("jogar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func playButtonClicked() {
        let vc = GameViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    lazy var leaderboardButton: UIButton = {
        let button = UIButton()
        button.setTitle("leaderboard", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(leaderboardButtonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func leaderboardButtonClicked() {
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        present(vc, animated: true, completion: nil)
    }
    
    lazy var achievementsButton: UIButton = {
        let button = UIButton()
        button.setTitle("achievements", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(achievementsButtonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func achievementsButtonClicked() {
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .achievements
        present(vc, animated: true, completion: nil)
    }
    
    
    // achievements
    //    @objc func showAchievements() {
    //        let vc = GKGameCenterViewController()
    //        vc.gameCenterDelegate = self
    //        vc.viewState = .achievements
    //        present(vc, animated: true, completion: nil)
    //    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // added landscape orientation
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "AnimationScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        authenticateUser()
        
        view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(leaderboardButton)
        leaderboardButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(60)
        }
        
        view.addSubview(achievementsButton)
        achievementsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-60)
        }
        
//        view.addSubview(unlockAchievementButton)
//        unlockAchievementButton.snp.makeConstraints { make in
//            make.centerX.equalTo(achievementsButton)
//            make.top.equalTo(achievementsButton.snp.bottom).offset(30)
//        }
        
//        view.addSubview(submitScoreButton)
//        submitScoreButton.snp.makeConstraints { make in
//            make.centerX.equalTo(leaderboardButton)
//            make.top.equalTo(leaderboardButton.snp.bottom).offset(30)
//        }
        
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
    
    func authenticateUser() {
        let player = GKLocalPlayer.local
        
        player.authenticateHandler = { vc, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let vc = vc {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
}

extension AnimationViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
}
