//
//  StoreViewController.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import UIKit
import SnapKit

class StoreViewController: UIViewController {
    private var coinManager = CoinManager(coinsRepository: UserDefaultsCoinsRepository())
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBrown2
        
        setupBackButton()
        setupPlayerCoinsView()
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
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
}
