//
//  HomeView.swift
//  Bike-Runner
//
//  Created by André Schueda on 10/02/22.
//

import UIKit
import GameKit
import SnapKit

class HomeView: UIView {
    private var parent: GameViewController
    
    lazy var logoView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .logo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(.playButton, for: .normal)
        button.setImage(.playButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func playButtonClicked() {
        guard let introNode = parent.gameScene?.introNode else { return }
        parent.gameScene?.addChild(introNode)
        parent.gameScene?.status = .intro
        parent.scoreView.alpha = 1
        parent.collectedCoinsView.alpha = 1

        alpha = 0
        
    }
    
    
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
    }
    
    
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
    }
    
    
    lazy var bikeButton: UIButton = {
        let button = UIButton()
        button.setImage(.bikeButton, for: .normal)
        button.setImage(.bikeButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(bikeButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func bikeButtonClicked() {
        let vc = StoreViewController()
        vc.bikerManager = parent.bikerManager
        vc.coinManager = parent.coinManager
        vc.modalPresentationStyle = .fullScreen
        parent.present(vc, animated: false, completion: nil)
    }
    
    init(parent: GameViewController, frame: CGRect = .zero) {
        self.parent = parent
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        
        setupPlayButton()
        setupAchievementButton()
        setupLeaderboardButton()
        setupBikeButton()
        
        setupLogoImageView()
    }
    
    private func setupPlayButton() {
        addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-UIScreen.main.bounds.height * 0.1)
        }
    }
    
    private func setupAchievementButton() {
        addSubview(achievementButton)
        achievementButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.trailing.equalTo(playButton.snp.leading).offset(-5)
            make.centerY.equalTo(playButton)
        }
    }
    
    private func setupLeaderboardButton() {
        addSubview(leaderboardButton)
        leaderboardButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.trailing.equalTo(achievementButton.snp.leading).offset(-5)
            make.centerY.equalTo(playButton)
        }
    }
    
    private func setupBikeButton() {
        addSubview(bikeButton)
        bikeButton.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(80)
            make.leading.equalTo(playButton.snp.trailing).offset(5)
            make.centerY.equalTo(playButton)
        }
    }
    
    private func setupLogoImageView() {
        addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(playButton.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        logoView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
