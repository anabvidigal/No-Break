//
//  ShopCollectionViewCell.swift
//  Bike-Runner
//
//  Created by André Schueda on 14/03/22.
//

import UIKit
import SnapKit

class ShopCollectionViewCell: UICollectionViewCell {
    var biker: Biker?
    
    lazy var headBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .check
        imageView.backgroundColor = .appGray
        return imageView
    }()
    
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    lazy var lockedOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray.withAlphaComponent(0.7)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        backgroundColor = .appGray
        
        setupHeadBackground()
        setupCheckImageView()
        setupHeadImageView()
        setupLockedOverlayView()
    }
    
    private func setupHeadBackground() {
        addSubview(headBackground)
        headBackground.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func setupCheckImageView() {
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupHeadImageView() {
        addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupLockedOverlayView() {
        addSubview(lockedOverlayView)
        lockedOverlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
    func set(biker: Biker) {
        headImageView.image = UIImage(named: "\(biker.id)_head")
        if biker.status == .selected {
            backgroundColor = .appBrightGreen
            checkImageView.alpha = 1
        } else {
            backgroundColor = .appGray
            checkImageView.alpha = 0

        }
        if biker.status != .forSale {
            lockedOverlayView.alpha = 0
        } else {
            lockedOverlayView.alpha = 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
