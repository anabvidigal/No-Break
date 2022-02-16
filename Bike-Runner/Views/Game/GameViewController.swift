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
import GoogleMobileAds

protocol GameSceneDelegate: AnyObject {
    func gameIsOver(_ sender: GameScene)
    func setHighscore(_ sender: GameScene)
    func score(_ sender: GameScene)
    func catchCoin(_ sender: GameScene)
    func reset()
}

class GameViewController: UIViewController, GameSceneDelegate, GADFullScreenContentDelegate {

    var gameScene: GameScene?
    var coinManager: CoinManager?
    var gameCenter = GameCenter()
    var bikerManager = BikerManager(bikersRepository: UserDefaultsBikersRepository())
    
    private var interstitialAd: GADInterstitialAd?
    private var rewardedAd: GADRewardedAd?
    
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
        gameScene?.lastUpdate = 0
        if let player = gameScene?.player {
            player.biker = bikerManager.selectedBiker
            player.startAnimation()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        requestInterstitial()
        requestRewarded()
        
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
    
    func requestInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Constants.testInterstitialAdUnitID, request: request, completionHandler: { [self] ad, error in
            if let error = error {
              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
              return
            }
            interstitialAd = ad
            interstitialAd?.fullScreenContentDelegate = self
          }
        )
    }
    
    func requestRewarded() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: Constants.testRewardedAdUnitID, request: request, completionHandler: { [self] ad, error in
            if let error = error {
              print("Failed to load rewarded ad with error: \(error.localizedDescription)")
              return
            }
            rewardedAd = ad
            rewardedAd?.fullScreenContentDelegate = self
          }
        )
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
        requestInterstitial()
        requestRewarded()
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
            scene.coinManager = coinManager
            scene.bikerManager = bikerManager
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
        gameOverView.coinsLabel.text = "Coins: \(coinManager?.playerCoins ?? 0)"
        gameOverView.collectedCoinsLabel.text = "+\(coinManager?.collectedCoins ?? 0)"
        gameOverView.updateCoinsStackConstrainsIf(isHighScore: sender.isHighscore)
//        showInterstitialAd()
    }
    
    func showInterstitialAd() {
        if interstitialAd != nil {
            interstitialAd!.present(fromRootViewController: self)
          } else {
            print("Ad wasn't ready")
          }
    }
    
    func showRewardedAd() {
        if rewardedAd != nil {
            rewardedAd!.present(fromRootViewController: self, userDidEarnRewardHandler: {
                print("doubled coins")
                self.coinManager?.doubleCoins()
                self.gameOverView.collectedCoinsLabel.text = "+\((self.coinManager?.collectedCoins ?? 0)/2)" + " x2"
                self.gameOverView.duplicateCoinsButton.isEnabled = false
            })
          } else {
            print("Ad wasn't ready")
          }
    }
    
    func score(_ sender: GameScene) {
        scoreView.scoreLabel.text = "\(sender.scoreDetector.score)"
        if sender.scoreDetector.score > sender.highscoreManager.highscore {
            scoreView.highscoreLabel.text = "\(sender.scoreDetector.score)"
        }
    }
    
    func catchCoin(_ sender: GameScene) {
        coinsView.coinsLabel.text = "\(sender.coinManager?.collectedCoins ?? 0)"
    }
    
    func setHighscore(_ sender: GameScene) {
        scoreView.highscoreLabel.text = "\(sender.highscoreManager.highscore)"
    }
    
    func reset() {
        scoreView.scoreLabel.text = "0"
        coinsView.coinsLabel.text = "0"
        gameOverView.duplicateCoinsButton.isEnabled = true
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
