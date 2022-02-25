//
//  PlayerCoinsView.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import UIKit
import SnapKit

class CoinsView: UIView {
    
    lazy var coinIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .coin
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(24)
        label.textColor = .appBrown2
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    init(frame: CGRect = .zero, width: CGFloat, height: CGFloat = 40) {
        super.init(frame: frame)
        
        backgroundColor = .appBeige
        snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        setupCoinIcon()
        setupCoinsLabel()
    }
    
    private func setupCoinIcon() {
        addSubview(coinIcon)
        coinIcon.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupCoinsLabel() {
        addSubview(coinsLabel)
        coinsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(coinIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }
    }
    
    func set(coins: Int) {
        coinsLabel.text = "\(coins)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
