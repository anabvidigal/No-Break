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

class GameOverView: UIView {
    
    private var parent: GameViewController
        
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backButton, for: .normal)
        button.setImage(.backButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    @objc func backClicked() {
        parent.gameScene?.reset()
        parent.gameScene?.status = .animating
        parent.gameScene?.introNode.removeFromParent()
        parent.homeView.alpha = 1
        parent.scoreView.alpha = 0
        parent.coinsView.alpha = 0
        
        alpha = 0
    }
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(52)
        label.textColor = .appBeige
        label.textAlignment = .center
        return label
    }()
    
    lazy var highscoreLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(26)
        label.textColor = .appGreen1
        label.textAlignment = .center
        label.text = "New highscore!"
        return label
    }()
    
    lazy var coinsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    
    lazy var coinsValueStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(40)
        label.textColor = .appBeige
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectedCoinsLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(40)
        label.textColor = .appGreen2
        label.textAlignment = .center
        return label
    }()
    
    lazy var duplicateCoinsButton: UIButton = {
        let button = UIButton()
        button.setImage(.duplicateCoinsButton, for: .normal)
        button.setImage(.duplicateCoinsButtonPressed, for: .highlighted)
        return button
    }()
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setImage(.restartButton, for: .normal)
        button.setImage(.restartButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(restartClicked), for: .touchUpInside)
        return button
    }()
    @objc func restartClicked() {
        alpha = 0
        parent.gameScene?.reset()
    }
    
    lazy var leaderboardButton: UIButton = {
        let button = UIButton()
        button.setImage(.smallLeaderboardButton, for: .normal)
        button.setImage(.smallLeaderboardButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(leaderboardButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func leaderboardButtonClicked() {
        let vc = GKGameCenterViewController.init(state: .leaderboards)
        vc.gameCenterDelegate = parent
        parent.present(vc, animated: true, completion: nil)
    }
    
    init(frame: CGRect = .zero, parent: GameViewController) {
        self.parent = parent
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .appBrown2
        layer.borderColor = UIColor.appBrown1.cgColor
        layer.borderWidth = 2
        
        setupBackButton()
        setupScoreLabel()
        setupHighscoreLabel()
        
        [
            coinsLabel,
            collectedCoinsLabel
        ].forEach { coinsValueStack.addArrangedSubview($0) }
        
        setupCoinsStack()
        [
            coinsValueStack,
            duplicateCoinsButton
        ].forEach { coinsStack.addArrangedSubview($0) }
        setupDuplicateCoinsButton()
        
        
        setupButtonsStack()
        [
            leaderboardButton,
            restartButton
        ].forEach { buttonsStack.addArrangedSubview($0) }
        setupLeaderboardButton()
        setupRestartButton()
    }
    
    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupHighscoreLabel() {
        addSubview(highscoreLabel)
        highscoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(-8)
        }
    }
    
    private func setupCoinsStack() {
        addSubview(coinsStack)
        coinsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(highscoreLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupDuplicateCoinsButton() {
        duplicateCoinsButton.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(60)
        }
    }
    
    private func setupButtonsStack() {
        addSubview(buttonsStack)
        buttonsStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupLeaderboardButton() {
        leaderboardButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
    
    private func setupRestartButton() {
        restartButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
    
    func updateCoinsStackConstrainsIf(isHighScore: Bool) {
        coinsStack.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(isHighScore ? highscoreLabel.snp.bottom : scoreLabel.snp.bottom).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
