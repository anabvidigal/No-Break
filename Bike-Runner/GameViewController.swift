//
//  GameViewController.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 28/01/22.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {

    lazy var skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // keep both from merge 
    
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
        
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                skView.presentScene(scene)
            }
            
            skView.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            authenticateUser()
            
        }
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
