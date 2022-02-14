//
//  GameStatsView.swift
//  Bike-Runner
//
//  Created by André Schueda on 11/02/22.
//

import Foundation
import UIKit
import SnapKit

class CoinsView: UIView {
    private var parent: GameViewController
    
    private lazy var coinsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coins"
        label.textAlignment = .left
        label.font = .kenneyFont.withSize(20)
        label.textColor = .appBrown2
        return label
    }()
    
    lazy var coinsLabel: UILabel = {
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
        
        setupCoinsTitlelabel()
        setupCoinsLabel()
    }
    
    private func setupCoinsTitlelabel() {
        addSubview(coinsTitleLabel)
        coinsTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
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
