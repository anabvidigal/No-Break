//
//  GameStatsView.swift
//  Bike-Runner
//
//  Created by André Schueda on 11/02/22.
//

import Foundation
import UIKit
import SnapKit

class ScoreView: UIView {
    private var parent: GameViewController
    
    private lazy var scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.textAlignment = .right
        label.font = .kenneyFont.withSize(20)
        label.textColor = .appBrown2
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .kenneyFont.withSize(20)
        label.textColor = .appBrown2
        label.text = "0"
        return label
    }()
    
    private lazy var highscoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Highscore"
        label.textAlignment = .right
        label.font = .kenneyFont.withSize(20)
        label.textColor = .appBrown2
        return label
    }()
    
    lazy var highscoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .kenneyFont.withSize(20)
        label.textColor = .appBrown2
        label.text = "0"
        return label
    }()
    
    init(frame: CGRect = .zero, parent: GameViewController) {
        self.parent = parent
        super.init(frame: frame)
        
        setupScoreTitleLabel()
        setupScoreLabel()
        
        setupHighscoreTitleLabel()
        setupHighscoreLabel()
    }
    
    private func setupScoreTitleLabel() {
        addSubview(scoreTitleLabel)
        scoreTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func setupScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(scoreTitleLabel.snp.bottom)
        }
    }
    
    private func setupHighscoreTitleLabel() {
        addSubview(highscoreTitleLabel)
        highscoreTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(4)
        }
    }
    
    private func setupHighscoreLabel() {
        addSubview(highscoreLabel)
        highscoreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(highscoreTitleLabel.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
