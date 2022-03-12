//
//  GameOverView.swift
//  Bike-Runner
//
//  Created by André Schueda on 10/02/22.
//

import UIKit
import GameKit
import SnapKit
import GoogleMobileAds
import SwiftySound

class GameOverView: UIView {
    
    private var parent: GameViewController
    
    lazy var innerRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown1
        return view
    }()
    
    lazy var collectedCoinsView: CoinsView = {
        let view = CoinsView(width: 80, height: 30)
        return view
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(36)
        label.textColor = .appBeige
        label.textAlignment = .center
        return label
    }()
    
    lazy var highscoreLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(18)
        label.textColor = .appBrightGreen
        label.textAlignment = .center
        label.text = "New highscore!"
        return label
    }()
    
    lazy var extraLifeButton: UIButton = {
        let button = UIButton()
        button.setImage(.extraLifeButton, for: .normal)
        button.setImage(.extraLifeButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(extraLifeButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func extraLifeButtonClicked() {
        parent.showRewardedAd()
//        playSound(sound: "tap", type: "wav")
    }
    
    lazy var playAgainButton: UIButton = {
        let button = UIButton()
        button.setImage(.playAgainButton, for: .normal)
        button.setImage(.playAgainButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(playAgainButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func playAgainButtonClicked() {
        parent.hideGameOver()
        parent.gameScene?.reset()
        Sound.play(file: "game-music.mp3")
    }
    
    lazy var outerRectangleView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var playerCoinsView: CoinsView = {
        let view = CoinsView(width: 86, height: 30)
        return view
    }()
    
    lazy var shopButton: UIButton = {
        let button = UIButton()
        button.setImage(.bikeButton, for: .normal)
        button.setImage(.bikeButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(shopButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func shopButtonClicked() {
        let vc = StoreViewController()
        vc.bikerManager = parent.bikerManager
        vc.coinManager = parent.coinManager
        vc.modalPresentationStyle = .fullScreen
        parent.present(vc, animated: false, completion: nil)
//        playSound(sound: "tap", type: "wav")
    }
    
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(16)
        label.textColor = .appGray
        label.textAlignment = .center
        label.text = "SHOP"
        return label
    }()
    
    lazy var leaderboardButton: UIButton = {
        let button = UIButton()
        button.setImage(.leaderboardButton, for: .normal)
        button.setImage(.leaderboardButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(leaderboardButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func leaderboardButtonClicked() {
        let vc = GKGameCenterViewController.init(state: .leaderboards)
        vc.gameCenterDelegate = parent
        parent.present(vc, animated: true, completion: nil)
//        playSound(sound: "tap", type: "wav")
    }
    
    lazy var scoresLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(16)
        label.textColor = .appGray
        label.textAlignment = .center
        label.text = "SCORES"
        return label
    }()
    
    lazy var achievementButton: UIButton = {
        let button = UIButton()
        button.setImage(.achievementButton, for: .normal)
        button.setImage(.achievementButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(achievementButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func achievementButtonClicked() {
        let vc = GKGameCenterViewController(state: .achievements)
        vc.gameCenterDelegate = parent
        GKAchievement.loadAchievements()
        parent.present(vc, animated: true, completion: nil)
//        playSound(sound: "tap", type: "wav")
    }
    
    lazy var awardsLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(16)
        label.textColor = .appGray
        label.textAlignment = .center
        label.text = "AWARDS"
        return label
    }()
    
    
    init(frame: CGRect = .zero, parent: GameViewController) {
        self.parent = parent
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .appBrown2
        
        setupInnerRectangleView()
        
        setupCollectedCoinsView()
        setupScoreLabel()
        setupHighscoreLabel()
        setupPlayAgainButton()
        setupExtraLifeButton()
        
        setupOuterRectangleView()
        
        setupPlayerCoinsView()
        setupShopButton()
        setupShopLabel()
        
        setupAwardsLabel()
        setupAchievementButton()
        setupScoresLabel()
        setupScoresButton()
        
    }
    
    private func setupInnerRectangleView() {
        addSubview(innerRectangleView)
        innerRectangleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(300)
        }
    }
    
    private func setupCollectedCoinsView() {
        innerRectangleView.addSubview(collectedCoinsView)
        collectedCoinsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
    }
    
    private func setupScoreLabel() {
        innerRectangleView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectedCoinsView.snp.bottom)
        }
    }
    
    private func setupHighscoreLabel() {
        innerRectangleView.addSubview(highscoreLabel)
        highscoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(-6)
        }
    }
    
    private func setupPlayAgainButton() {
        innerRectangleView.addSubview(playAgainButton)
        playAgainButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            
        }
    }
    
    private func setupExtraLifeButton() {
        innerRectangleView.addSubview(extraLifeButton)
        extraLifeButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(playAgainButton.snp.top).offset(-8)
        }
    }
    
    private func setupOuterRectangleView() {
        addSubview(outerRectangleView)
        outerRectangleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(innerRectangleView.snp.trailing)
        }
    }
    
    private func setupPlayerCoinsView() {
        outerRectangleView.addSubview(playerCoinsView)
        playerCoinsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
    }
    
    private func setupShopButton() {
        outerRectangleView.addSubview(shopButton)
        shopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(playerCoinsView.snp.bottom)
            make.width.equalTo(90)
            make.height.equalTo(40)
        }
    }
    
    private func setupShopLabel() {
        outerRectangleView.addSubview(shopLabel)
        shopLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(shopButton.snp.bottom)
        }
    }
    
    private func setupAwardsLabel() {
        outerRectangleView.addSubview(awardsLabel)
        awardsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    private func setupAchievementButton() {
        outerRectangleView.addSubview(achievementButton)
        achievementButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(awardsLabel.snp.top)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func setupScoresLabel() {
        outerRectangleView.addSubview(scoresLabel)
        scoresLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(achievementButton.snp.top).offset(-8)
        }
    }
    
    private func setupScoresButton() {
        outerRectangleView.addSubview(leaderboardButton)
        leaderboardButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scoresLabel.snp.top)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
