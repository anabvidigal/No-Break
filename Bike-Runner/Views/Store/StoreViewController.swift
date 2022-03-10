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
    
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.text = "BIKER'S SHOP"
        label.font = .kenneyFont.withSize(26)
        label.textColor = .appBeige
        label.textAlignment = .left
        return label
    }()
    
    lazy var moreCoinsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBrown1
        return button
    }()
    
    lazy var playerCoinsView: CoinsView = {
        let view = CoinsView(width: 120)
        view.set(coins: coinManager?.playerCoins ?? 0)
        return view
    }()
    
    lazy var walletLabel: UILabel = {
        let label = UILabel()
        label.text = "WALLET"
        label.font = .kenneyFont.withSize(18)
        label.textColor = .appBeige
        label.textAlignment = .left
        return label
    }()

    lazy var ridersCollection: UIView = {
        let collection = UIView()
        collection.backgroundColor = .red
        return collection
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBeige
        return view
    }()
    
    lazy var ambientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
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
    
    lazy var riderInfoView: UIView = {
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
        view.backgroundColor = .appBrown2
        
        setupBackButton()
        setupShopLabel()
        
        setupMoreCoinsButton()
        setupPlayerCoinsView()
        setupWalletLabel()
        
        setupRidersCollection()
        
        setupBackgroundView()
        setupAmbientImageView()
        
        setupConfirmationPopUpView()
        
        guard let selectedBiker = bikerManager?.getSelectedBiker() else { return }
        show(biker: selectedBiker)
    }

    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(22)
        }
    }
    
    private func setupShopLabel() {
        view.addSubview(shopLabel)
        shopLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.leading.equalTo(backButton.snp.trailing).offset(20)
        }
    }
    
    private func setupMoreCoinsButton() {
        view.addSubview(moreCoinsButton)
        moreCoinsButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalTo(backButton)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    private func setupPlayerCoinsView() {
        view.addSubview(playerCoinsView)
        playerCoinsView.snp.makeConstraints { make in
            make.trailing.equalTo(moreCoinsButton.snp.leading)
            make.centerY.equalTo(moreCoinsButton)
        }
    }
    
    private func setupWalletLabel() {
        view.addSubview(walletLabel)
        walletLabel.snp.makeConstraints { make in
            make.centerY.equalTo(playerCoinsView)
            make.trailing.equalTo(playerCoinsView.snp.leading).offset(-16)
        }
    }
    
    private func setupRidersCollection() {
        view.addSubview(ridersCollection)
        ridersCollection.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.leading.equalTo(backButton.snp.trailing).offset(20)
            make.width.equalTo(166)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.leading.equalTo(ridersCollection.snp.trailing).offset(16)
            make.trailing.equalTo(moreCoinsButton)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
        }
    }
    
    private func setupAmbientImageView() {
        backgroundView.addSubview(ambientImageView)
        ambientImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(ambientImageView.snp.height).multipliedBy(1044 / 816)
        }
    }
    
    private func setupSelectButton() {
        riderInfoView.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(180)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupPriceView() {
        riderInfoView.addSubview(priceView)
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
