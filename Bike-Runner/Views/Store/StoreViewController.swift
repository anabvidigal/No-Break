//
//  StoreViewController.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import UIKit
import SnapKit

class StoreViewController: UIViewController {
    var bikerManager = BikerManager(bikersRepository: UserDefaultsBikersRepository())
    var coinManager = CoinManager(coinsRepository: UserDefaultsCoinsRepository())
    
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
        let view = PlayerCoinsView(coins: coinManager.playerCoins)
        view.layer.borderColor = UIColor.appBrown1.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    lazy var bikerHeaderView: BikerHeaderView = {
        let view = BikerHeaderView(parent: self)
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    lazy var bikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Selected", for: .normal)
        button.titleLabel?.font = .kenneyFont.withSize(30)
        button.backgroundColor = .appGreen1
        return button
    }()
    
    lazy var bikerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBeige
        
        setupBackButton()
        setupPlayerCoinsView()
        
        setupBikerHeaderView()
        
        setupContentStack()
        [
            bikeImageView,
            bikerImageView,
            selectButton
        ].forEach { contentStack.addArrangedSubview($0) }
        setupSelectButton()
        
        show(biker: bikerManager.selectedBiker)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
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
    
    private func setupBikerHeaderView() {
        view.addSubview(bikerHeaderView)
        bikerHeaderView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    private func setupContentStack() {
        view.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.top.equalTo(bikerHeaderView.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    private func setupSelectButton() {
        selectButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(180)
        }
    }
    
    func show(biker: Biker) {
        bikerHeaderView.nameLabel.text = biker.name
        bikerHeaderView.descriptionLabel.text = biker.description
        bikeImageView.image = UIImage(named: "\(biker.id)_bike")
        bikerImageView.image = UIImage(named: "\(biker.id)_rider")
        selectButton.backgroundColor = [.blue, .red, .orange].shuffled().first!
    }
}
