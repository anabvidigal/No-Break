//
//  PriceView.swift
//  Bike-Runner
//
//  Created by André Schueda on 15/02/22.
//

import UIKit
import SnapKit
import SwiftySound

class PriceView: UIView {
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(24)
        label.textAlignment = .center
        label.text = "1000"
        label.textColor = .appBrown2
        return label
    }()
    
    lazy var coinIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .coin
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupPriceLabel()
        setupCoinIcon()
    }
    
    private func setupPriceLabel() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupCoinIcon() {
        addSubview(coinIcon)
        coinIcon.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(1)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(coinIcon.snp.height)
            make.trailing.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
