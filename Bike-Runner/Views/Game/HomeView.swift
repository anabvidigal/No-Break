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
    
    lazy var buttonsView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown1.withAlphaComponent(0.7)
        return view
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

        alpha = 0
    }
    
    lazy var playLabel: UILabel = {
        let label = UILabel()
        label.text = "PLAY"
        label.font = .kenneyFont.withSize(16)
        label.textColor = .appBeige
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
    }
    
    lazy var awardLabel: UILabel = {
        let label = UILabel()
        label.text = "AWARDS"
        label.font = .kenneyFont.withSize(16)
        label.textColor = .appBeige
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
        parent.coinManager?.hitTheJackpot()
        let vc = GKGameCenterViewController.init(state: .leaderboards)
        vc.gameCenterDelegate = parent
        parent.present(vc, animated: true, completion: nil)
    }
    
    lazy var scoresLabel: UILabel = {
        let label = UILabel()
        label.text = "SCORES"
        label.font = .kenneyFont.withSize(16)
        label.textColor = .appBeige
        return label
    }()
    
    
    lazy var bikeButton: UIButton = {
        let button = UIButton()
        button.setImage(.bikeButton, for: .normal)
        button.setImage(.bikeButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(bikeButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func bikeButtonClicked() {
        let vc = ShopViewController()
        vc.bikerManager = parent.bikerManager
        vc.coinManager = parent.coinManager
        vc.modalPresentationStyle = .fullScreen
        parent.present(vc, animated: false, completion: nil)
    }
    
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.text = "SHOP"
        label.font = .kenneyFont.withSize(16)
        label.textColor = .appBeige
        return label
    }()
    
    init(parent: GameViewController, frame: CGRect = .zero) {
        self.parent = parent
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupButtonsView()
        
        setupPlayButton()
        setupPlayLabel()
        
        setupAchievementButton()
        setupAwardLabel()
        
        setupLeaderboardButton()
        setupScoresLabel()
        
        setupBikeButton()
        setupShopLabel()
        
        setupLogoImageView()
    }
    
    private func setupButtonsView() {
        addSubview(buttonsView)
        buttonsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-22)
        }
    }
    
    private func setupPlayButton() {
        buttonsView.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(80)
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupPlayLabel() {
        buttonsView.addSubview(playLabel)
        playLabel.snp.makeConstraints { make in
            make.centerX.equalTo(playButton)
            make.top.equalTo(playButton.snp.bottom)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    private func setupAchievementButton() {
        buttonsView.addSubview(achievementButton)
        achievementButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.trailing.equalTo(playButton.snp.leading).offset(-5)
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupAwardLabel() {
        buttonsView.addSubview(awardLabel)
        awardLabel.snp.makeConstraints { make in
            make.centerX.equalTo(achievementButton)
            make.top.equalTo(achievementButton.snp.bottom)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    private func setupLeaderboardButton() {
        buttonsView.addSubview(leaderboardButton)
        leaderboardButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.trailing.equalTo(achievementButton.snp.leading).offset(-5)
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalTo(playButton)
        }
    }
    
    private func setupScoresLabel() {
        buttonsView.addSubview(scoresLabel)
        scoresLabel.snp.makeConstraints { make in
            make.centerX.equalTo(leaderboardButton)
            make.top.equalTo(leaderboardButton.snp.bottom)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    private func setupBikeButton() {
        buttonsView.addSubview(bikeButton)
        bikeButton.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(80)
            make.leading.equalTo(playButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalTo(playButton)
        }
    }
    
    private func setupShopLabel() {
        buttonsView.addSubview(shopLabel)
        shopLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bikeButton)
            make.top.equalTo(bikeButton.snp.bottom)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    private func setupLogoImageView() {
        addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(buttonsView.snp.top)
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
