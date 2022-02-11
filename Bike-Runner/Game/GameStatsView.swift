//
//  GameStatsView.swift
//  Bike-Runner
//
//  Created by André Schueda on 11/02/22.
//

import Foundation
import UIKit
import SnapKit

class GameStatsView: UIView {
    private var parent: GameViewController
    
    private lazy var scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Score:"
        label.font = .kenneyFont.withSize(16)
        label.textColor = .white
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .kenneyFont.withSize(16)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private lazy var coinsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coins:"
        label.font = .kenneyFont.withSize(16)
        label.textColor = .white
        return label
    }()
    
    lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .kenneyFont.withSize(16)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    init(frame: CGRect = .zero, parent: GameViewController) {
        self.parent = parent
        super.init(frame: frame)
        
        setupScoreTitleLabel()
        setupScoreLabel()
        
        setupCoinsTitlelabel()
        setupCoinsLabel()
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
    
    private func setupCoinsTitlelabel() {
        addSubview(coinsTitleLabel)
        coinsTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(4)
        }
    }
    
    private func setupCoinsLabel() {
        addSubview(coinsLabel)
        coinsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(coinsTitleLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
