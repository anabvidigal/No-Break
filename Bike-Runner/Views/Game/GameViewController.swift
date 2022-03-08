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
    func score(_ sender: GameScene)
    func catchCoin(_ sender: GameScene)
    func showStats()
    func reset()
}

class GameViewController: UIViewController, GameSceneDelegate, GADFullScreenContentDelegate {

    var gameScene: GameScene?
    
    var coinManager: CoinManager?
    var bikerManager: BikerManager?
    var scoreManager: ScoreManager?
    var gameCenter: GameCenter?
    var hapticsManager: HapticsManager?
    
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
    
    lazy var collectedCoinsView: CoinsView = {
        let view = CoinsView(width: 80, height: 30)
        view.alpha = 0
        return view
    }()
    
    lazy var gameOverView: GameOverView = {
        let view = GameOverView(parent: self)
        view.alpha = 0
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backButton, for: .normal)
        button.setImage(.backButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    @objc func backButtonClicked() {
        gameScene?.reset()
        gameScene?.status = .animating
        gameScene?.introNode.removeFromParent()
        homeView.alpha = 1
        scoreView.alpha = 0
        collectedCoinsView.alpha = 0
        
        hideGameOver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let player = gameScene?.player,
              let bikerManager = bikerManager else { return }
        player.biker = bikerManager.getSelectedBiker()
        player.startAnimation()
        if gameScene?.status != .animating && gameScene?.status != .intro {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                player.die()                
            }
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
        setupBackButton()
    
        gameCenter?.authenticateUser(self)
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
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
        requestInterstitial()
        requestRewarded()
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
                self.gameOverView.alpha = 0
                self.backButton.alpha = 0
                self.gameScene?.continueGame()
                self.gameOverView.extraLifeButton.isEnabled = false
            })
          } else {
              self.gameOverView.extraLifeButton.isEnabled = false
              print("Ad wasn't ready")
          }
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
            scene.scoreManager = scoreManager
            scene.gameCenter = gameCenter
            scene.hapticsManager = hapticsManager
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
            make.leading.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(16)
        }
    }
    
    private func setupCoinsView() {
        view.addSubview(collectedCoinsView)
        collectedCoinsView.snp.makeConstraints { make in
            make.centerY.equalTo(scoreView)
            make.leading.equalTo(scoreView.snp.trailing).offset(8)
        }
    }
    
    private func setupGameOverView() {
        view.addSubview(gameOverView)
        gameOverView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(500)
            make.height.equalTo(300)
        }
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalTo(gameOverView)
            make.trailing.equalTo(gameOverView.snp.leading).offset(-8)
        }
    }

    func gameIsOver(_ sender: GameScene) {
        hideStats()
        coinManager?.addCollectedCoins()
        showGameOver()
        if scoreManager?.currentScore ?? 0 % 7 == 0 {
            showInterstitialAd()
        }
    }
    
    private func hideStats() {
        collectedCoinsView.alpha = 0
        scoreView.alpha = 0
    }
    
    private func showGameOver() {
        guard let scoreManager = scoreManager else { return }
        gameOverView.alpha = 1
        backButton.alpha = 1
        gameOverView.collectedCoinsView.set(collectedCoins: coinManager?.collectedCoins ?? 0)
        gameOverView.playerCoinsView.set(coins: coinManager?.playerCoins ?? 0, fontSize: 16)
        gameOverView.scoreLabel.text = "Score: \(scoreManager.currentScore)"
        gameOverView.highscoreLabel.alpha = scoreManager.currentScoreIsHighscore ? 1 : 0
    }
    
    func hideGameOver() {
        gameOverView.alpha = 0
        backButton.alpha = 0
        gameOverView.extraLifeButton.isEnabled = true
    }
    
    func showStats() {
        collectedCoinsView.alpha = 1
        scoreView.alpha = 1
    }
    
    func score(_ sender: GameScene) {
        guard let scoreManager = scoreManager else { return }
        scoreView.scoreLabel.text = "\(scoreManager.currentScore)"
    }
    
    func catchCoin(_ sender: GameScene) {
        collectedCoinsView.set(coins: coinManager?.collectedCoins ?? 0)
    }
    
    func reset() {
        scoreView.scoreLabel.text = "0"
        collectedCoinsView.coinsLabel.text = "0"
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
