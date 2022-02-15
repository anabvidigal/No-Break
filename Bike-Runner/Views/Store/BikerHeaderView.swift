//
//  BikerHeaderView.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import UIKit
import SnapKit

class BikerHeaderView: UIView {
    private var parent: StoreViewController

    lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setImage(.previousButton, for: .normal)
        button.setImage(.previousButtonPressed, for: .highlighted)
        button.setImage(.previousButtonDisabled, for: .disabled)
        button.addTarget(self, action: #selector(clickedPreviousButton), for: .touchUpInside)
        return button
    }()
    @objc func clickedPreviousButton() {
        guard let previousBiker = parent.bikerManager?.getPreviousBiker() else { return }
        parent.show(biker: previousBiker)
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(30)
        label.textAlignment = .center
        label.textColor = .appBrown1
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(24)
        label.textAlignment = .center
        label.textColor = .appBrown2
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(.nextButton, for: .normal)
        button.setImage(.nextButtonPressed, for: .highlighted)
        button.setImage(.nextButtonDisabled, for: .disabled)
        button.addTarget(self, action: #selector(clickedNextButton), for: .touchUpInside)
        return button
    }()
    @objc func clickedNextButton() {
        guard let nextBiker = parent.bikerManager?.getNextBiker() else { return }
        parent.show(biker: nextBiker)
    }
    
    init(frame: CGRect = .zero, parent: StoreViewController) {
        self.parent = parent
        super.init(frame: frame)
        
        backgroundColor = .appGreen3
        
        setupPreviousButton()
        setupNextButton()
        
        setupNameLabel()
        setupDescriptionLabel()
        
    }
    
    private func setupPreviousButton() {
        addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func setupNextButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(previousButton.snp.trailing)
            make.trailing.equalTo(nextButton.snp.leading)
        }
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(previousButton.snp.trailing)
            make.trailing.equalTo(nextButton.snp.leading)
        }
    }
    
    func set(biker: Biker) {
        nameLabel.text = biker.name
        descriptionLabel.text = biker.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
