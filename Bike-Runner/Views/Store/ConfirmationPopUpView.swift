//
//  ConfirmationPopUpView.swift
//  Bike-Runner
//
//  Created by André Schueda on 15/02/22.
//

import UIKit
import SnapKit

class ConfirmationPopUpView: UIView {

    lazy var darkeningView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown1.withAlphaComponent(0.6)
        return view
    }()
    
    lazy var popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown2
        view.layer.borderColor = UIColor.appBrown1.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(30)
        label.textAlignment = .center
        label.textColor = .appBeige
        label.text = "Are you sure?"
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(24)
        label.textAlignment = .center
        label.textColor = .appGreen3
        label.text = "This will cost 150 coins"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupDarkeningView()
        setupPopUpView()
        setupTitleLabel()
        setupTextLabel()
    }
    
    private func setupDarkeningView() {
        addSubview(darkeningView)
        darkeningView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupPopUpView() {
        addSubview(popUpView)
        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(200)
        }
    }
    
    private func setupTitleLabel() {
        popUpView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func setupTextLabel() {
        popUpView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
