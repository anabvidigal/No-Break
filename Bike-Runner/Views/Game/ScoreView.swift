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
        label.text = "Score:"
        label.textAlignment = .left
        label.font = .kenneyFont.withSize(20)
        label.textColor = .appBrown2
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .kenneyFont.withSize(24)
        label.textColor = .appBrown2
        label.text = "0"
        return label
    }()
    
    init(frame: CGRect = .zero, parent: GameViewController) {
        self.parent = parent
        super.init(frame: frame)
        backgroundColor = .appBeige
        snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(30)
        }
        
        setupScoreTitleLabel()
        setupScoreLabel()
    }
    
    private func setupScoreTitleLabel() {
        addSubview(scoreTitleLabel)
        scoreTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
    }
    
    private func setupScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(scoreTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
