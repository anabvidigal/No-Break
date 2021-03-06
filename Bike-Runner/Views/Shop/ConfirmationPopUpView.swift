//
//  ConfirmationPopUpView.swift
//  Bike-Runner
//
//  Created by André Schueda on 15/02/22.
//

import UIKit
import SnapKit
import SwiftySound

class ConfirmationPopUpView: UIView {
    private weak var parent: ShopViewController?

    lazy var darkeningView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown1.withAlphaComponent(0.6)
        return view
    }()
    
    lazy var popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown2
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
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setImage(.confirmButton, for: .normal)
        button.setImage(.confirmButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(clickedConfirmButton), for: .touchUpInside)
        return button
    }()
    @objc func clickedConfirmButton() {
        guard let bikerManager = parent?.bikerManager,
              let coinManager = parent?.coinManager else { return }
        coinManager.spend(coins: bikerManager.showingBiker.price)
        parent?.playerCoinsView.set(coins: coinManager.playerCoins)
        bikerManager.selectShowingBiker()
        parent?.bikersCollectionView.reloadData()
        parent?.setButtonToSelected()
        alpha = 0
        parent?.soundManager?.playSuccessSound()
    }
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(.cancelButton, for: .normal)
        button.setImage(.cancelButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(clickedCancelButton), for: .touchUpInside)
        return button
    }()
    @objc func clickedCancelButton() {
        alpha = 0
        parent?.soundManager?.playTapSound()
    }
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setImage(.okButton, for: .normal)
        button.setImage(.okButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(clickedOkButton), for: .touchUpInside)
        return button
    }()
    @objc func clickedOkButton() {
        alpha = 0
        parent?.soundManager?.playTapSound()
    }
    
    
    init(frame: CGRect = .zero, parent: ShopViewController) {
        self.parent = parent
        super.init(frame: frame)
        
        setupDarkeningView()
        setupPopUpView()
        setupTitleLabel()
        setupTextLabel()
        
        setupButtonsStack()
        
        setupOkButton()
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
            make.width.equalTo(300)
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
    
    private func setupButtonsStack() {
        popUpView.addSubview(buttonsStack)
        buttonsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
        
        [
            confirmButton,
            cancelButton
        ].forEach { buttonsStack.addArrangedSubview($0) }
        setupConfirmButton()
        setupCancelButton()
    }
    
    private func setupConfirmButton() {
        confirmButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    private func setupCancelButton() {
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    private func setupOkButton() {
        popUpView.addSubview(okButton)
        okButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func showBuyConfirmation(for price: Int) {
        alpha = 1
        titleLabel.text = "Are you sure?"
        textLabel.text = "This will cost \(price) coins"
        okButton.alpha = 0
        buttonsStack.alpha = 1
    }
    
    func showNotEnoughCoins(for price: Int, with coins: Int) {
        alpha = 1
        titleLabel.text = "Not enough coins!"
        textLabel.text = "You need more \(price - coins) coins"
        buttonsStack.alpha = 0
        okButton.alpha = 1
    }

    func showRewardsEarned(for coins: Int) {
        alpha = 1
        titleLabel.text = "Well done!"
        textLabel.text = "You have earned \(coins) coins"
        buttonsStack.alpha = 0
        okButton.alpha = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
