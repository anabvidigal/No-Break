//
//  StoreViewController.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import UIKit
import SnapKit

class StoreViewController: UIViewController {
    var bikerManager: BikerManager?
    var coinManager: CoinManager?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backButton, for: .normal)
        button.setImage(.backButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func backButtonClicked() {
        dismiss(animated: false, completion: nil)
    }
    
    lazy var playerCoinsView: PlayerCoinsView = {
        let view = PlayerCoinsView(coinManager: coinManager)
        return view
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBeige
        return view
    }()
    
    lazy var bikerHeaderView: BikerHeaderView = {
        let view = BikerHeaderView(parent: self)
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .bottom
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var bikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bikerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var selectButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setImage(.selectedButton, for: .normal)
        button.setImage(.buyButtonPressed, for: .highlighted)
        button.addTarget(selectButtonClicked, action: #selector(selectButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func selectButtonClicked() {
        switch bikerManager?.showingBiker.status {
        case .bought:
            bikerManager?.selectShowingBiker()
            setButtonToSelected()
        case .forSale:
            showConfirmationPopUp()
        default:
            break
        }
    }
    
    private func showConfirmationPopUp() {
        guard let playerCoins = coinManager?.playerCoins,
              let bikerPrice = bikerManager?.showingBiker.price else { return }
        
        confirmationPopUpView.alpha = 1
        if playerCoins >= bikerPrice {
            confirmationPopUpView.titleLabel.text = "Are you sure?"
            confirmationPopUpView.textLabel.text = "This will cost \(bikerPrice) coins"
            confirmationPopUpView.okButton.alpha = 0
            confirmationPopUpView.buttonsStack.alpha = 1
        } else {
            confirmationPopUpView.titleLabel.text = "Not enough coins!"
            confirmationPopUpView.textLabel.text = "You need more \(bikerPrice - playerCoins) coins"
            confirmationPopUpView.buttonsStack.alpha = 0
            confirmationPopUpView.okButton.alpha = 1
        }
    }
    
    lazy var priceView: PriceView = {
        let view = PriceView()
        return view
    }()
    
    lazy var confirmationPopUpView: ConfirmationPopUpView = {
        let view = ConfirmationPopUpView(parent: self)
        view.alpha = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBrown1
        
        setupBackButton()
        setupPlayerCoinsView()
        
        setupBackgroundView()
        
        setupBikerHeaderView()
        
        setupContentStack()
        [
            bikeImageView,
            bikerImageView,
            selectButtonView
        ].forEach { contentStack.addArrangedSubview($0) }
        setupSelectButton()
        setupPriceView()
        
        setupConfirmationPopUpView()
        
        guard let selectedBiker = bikerManager?.getSelectedBiker() else { return }
        show(biker: selectedBiker)
    }

    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
    
    private func setupPlayerCoinsView() {
        view.addSubview(playerCoinsView)
        playerCoinsView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    private func setupBikerHeaderView() {
        backgroundView.addSubview(bikerHeaderView)
        bikerHeaderView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupContentStack() {
        backgroundView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.top.equalTo(bikerHeaderView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupSelectButton() {
        selectButtonView.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(180)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupPriceView() {
        selectButtonView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.centerX.equalTo(selectButton)
            make.bottom.equalTo(selectButton.snp.top).offset(-4)
            make.top.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    private func setupConfirmationPopUpView() {
        view.addSubview(confirmationPopUpView)
        confirmationPopUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func show(biker: Biker) {
        bikerHeaderView.nameLabel.text = biker.name
        bikerHeaderView.descriptionLabel.text = biker.description
        bikeImageView.image = UIImage(named: "\(biker.id)_bike")
        bikerImageView.image = UIImage(named: "\(biker.id)_rider")
        priceView.priceLabel.text = "\(biker.price)"
        
        switch biker.status {
        case .unregistered:
            print("Error: sending biker with unregistred status")
        case .selected:
            setButtonToSelected()
        case .bought:
            priceView.alpha = 0
            selectButton.isEnabled = true
            selectButton.setImage(.selectButton, for: .normal)
            selectButton.setImage(.selectButtonPressed, for: .highlighted)
        case .forSale:
            priceView.alpha = 1
            selectButton.isEnabled = true
            selectButton.setImage(.buyButton, for: .normal)
            selectButton.setImage(.buyButtonPressed, for: .highlighted)
        }
    }
    
    func setButtonToSelected() {
        priceView.alpha = 0
        selectButton.isEnabled = false
        selectButton.setImage(.selectedButton, for: .disabled)
    }
}
