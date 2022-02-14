//
//  PlayerCoinsView.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import UIKit
import SnapKit

class PlayerCoinsView: UIView {
    var coins: Int
    
    lazy var coinIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .coin
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(24)
        label.textColor = .appBeige
        label.textAlignment = .right
        label.text = "\(coins)"
        return label
    }()
    
    init(frame: CGRect = .zero, coins: Int) {
        self.coins = coins
        super.init(frame: frame)
        
        setupCoinIcon()
        setupCoinsLabel()
    }
    
    func setupCoinIcon() {
        addSubview(coinIcon)
        coinIcon.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupCoinsLabel() {
        addSubview(coinsLabel)
        coinsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(coinIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
