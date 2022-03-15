//
//  StoreViewController.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import UIKit
import SnapKit
import SwiftySound

class ShopViewController: UIViewController {
    var bikerManager: BikerManager?
    var coinManager: CoinManager?
    var soundManager: SoundManager?
    var adManager: AdManager?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backButton, for: .normal)
        button.setImage(.backButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func backButtonClicked() {
        dismiss(animated: false, completion: nil)
        soundManager?.playTapSound()
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
        button.setImage(.moreButton, for: .normal)
        button.setImage(.moreButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(moreCoinsButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func moreCoinsButtonClicked() {
        adManager?.showRewardedAd(self)
        soundManager?.playTapSound()
        soundManager?.stopMenuMusic()
    }
    
    
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

    lazy var bikersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBeige
        return view
    }()
    
    lazy var ambientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .shopAmbient
        return imageView
    }()
    
    lazy var bikerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bikerInfoView: UIView = {
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
            bikersCollectionView.reloadData()
            setButtonToSelected()
            soundManager?.playSelectSound()
        case .forSale:
            showConfirmationPopUp()
            soundManager?.playTapSound()
        default:
            break
        }
    }
    
    private func showConfirmationPopUp() {
        guard let playerCoins = coinManager?.playerCoins,
              let bikerPrice = bikerManager?.showingBiker.price else { return }
        
        if playerCoins >= bikerPrice {
            confirmationPopUpView.showBuyConfirmation(for: bikerPrice)
        } else {
            confirmationPopUpView.showNotEnoughCoins(for: bikerPrice, with: playerCoins)
        }
    }
    
    lazy var priceView: PriceView = {
        let view = PriceView()
        return view
    }()
    
    lazy var bikerTextView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var bikerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(24)
        label.textColor = .appBrown2
        label.text = bikerManager?.getSelectedBiker().name
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var bikerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont.withSize(18)
        label.textColor = .appBrown2
        label.text = bikerManager?.getSelectedBiker().description
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
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
        
        setupBikersCollection()
        
        setupBackgroundView()
        
        setupAmbientImageView()
        setupBikerImageView()
        setupBikeImageView()
        
        setupBikerInfoView()
        setupSelectButton()
        setupPriceView()
        
        setupBikerTextView()
        
        setupConfirmationPopUpView()
        
        guard let selectedBiker = bikerManager?.getSelectedBiker() else { return }
        show(biker: selectedBiker)
    }

    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(16)
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
    
    private func setupBikersCollection() {
        view.addSubview(bikersCollectionView)
        bikersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(168)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.leading.equalTo(bikersCollectionView.snp.trailing).offset(16)
            make.trailing.equalTo(moreCoinsButton)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
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
    
    private func setupBikerImageView() {
        ambientImageView.addSubview(bikerImageView)
        bikerImageView.snp.makeConstraints { make in
            make.trailing.equalTo(ambientImageView.snp.centerX)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(bikerImageView.snp.width)
            make.bottom.equalToSuperview().multipliedBy(0.87)
        }
    }
    
    private func setupBikeImageView() {
        ambientImageView.addSubview(bikeImageView)
        bikeImageView.snp.makeConstraints { make in
            make.leading.equalTo(ambientImageView.snp.centerX)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(bikerImageView.snp.width)
            make.bottom.equalToSuperview().multipliedBy(0.87)
        }
    }
    
    private func setupBikerInfoView() {
        backgroundView.addSubview(bikerInfoView)
        bikerInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(ambientImageView.snp.trailing)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func setupSelectButton() {
        bikerInfoView.addSubview(selectButton)
        bikerInfoView.setNeedsLayout()
        bikerInfoView.layoutIfNeeded()
        selectButton.snp.makeConstraints { make in
            print(min(180, bikerInfoView.frame.size.height - 16))
            make.width.lessThanOrEqualTo(min(180, bikerInfoView.frame.size.width - 16))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(selectButton.snp.width).multipliedBy(0.3333333333)
        }
    }
    
    private func setupPriceView() {
        bikerInfoView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.centerX.equalTo(selectButton)
            make.bottom.equalTo(selectButton.snp.top).offset(-4)
            make.height.equalTo(24)
        }
    }
    
    private func setupBikerTextView() {
        bikerInfoView.addSubview(bikerTextView)
        bikerTextView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(selectButton.snp.top)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        setupBikerNameLabel()
        setupBikerDescriptionLabel()
    }
    
    private func setupBikerNameLabel() {
        bikerTextView.addSubview(bikerNameLabel)
        bikerNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bikerTextView.snp.centerY).offset(-5)
        }
    }
    
    private func setupBikerDescriptionLabel() {
        bikerTextView.addSubview(bikerDescriptionLabel)
        bikerDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(bikerTextView.snp.centerY).offset(5)
        }
    }
    
    
    
    private func setupConfirmationPopUpView() {
        view.addSubview(confirmationPopUpView)
        confirmationPopUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func show(biker: Biker) {
        bikerNameLabel.text = biker.name
        bikerDescriptionLabel.text = biker.description
        bikeImageView.image = UIImage(named: "\(biker.id)_bike_border")
        bikerImageView.image = UIImage(named: "\(biker.id)_rider_border")
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


extension ShopViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let biker = bikerManager?.bikers[indexPath.row] else { return }
        show(biker: biker)
        bikerManager?.setShowing(biker: biker)
        soundManager?.playTapSound()
    }
}

extension ShopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bikerManager?.bikers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopCollectionViewCell
        if let biker = bikerManager?.bikers[indexPath.row] {
            cell.set(biker: biker)
        }
        return cell
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 80)
    }
}


extension ShopViewController: AdShower {
    func rewardedWasShowed() {
        let earnedCoins = Int.random(in: 8...13)
        coinManager?.notAddedCollectedCoins = earnedCoins
        coinManager?.addCollectedCoins()
        playerCoinsView.set(coins: coinManager?.playerCoins ?? 0)
        confirmationPopUpView.showRewardsEarned(for: earnedCoins)
        soundManager?.playMenuMusic()
    }
    
    func rewardedWasNotShowed() {
        moreCoinsButton.isEnabled = false
//        soundManager?.playMenuMusic()
    }
}
