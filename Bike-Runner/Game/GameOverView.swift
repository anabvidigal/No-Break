//
//  GameOverView.swift
//  Bike-Runner
//
//  Created by André Schueda on 10/02/22.
//

import UIKit
import GameKit
import SnapKit

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
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 5
        return stack
    }()
    
    lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(40)
        label.textColor = .appBeige
        label.textAlignment = .center
        label.text = "Coins: \(Int.random(in: 0...20))"
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
        parent.gameScene?.reset()
        parent.gameOverView.alpha = 0
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
        
        setupCoinsStack()
        [
            coinsLabel,
            duplicateCoinsButton
        ].forEach { coinsStack.addArrangedSubview($0) }
        setupDuplicateCoinsButton()
    }
    
    private func setupRestartButton() {
        restartButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
    }
    
    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom)
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
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
