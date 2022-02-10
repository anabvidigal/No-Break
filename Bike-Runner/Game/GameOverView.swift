//
//  GameOverView.swift
//  Bike-Runner
//
//  Created by André Schueda on 10/02/22.
//

import UIKit

class GameOverView: UIView {
    private var parent: GameViewController
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setImage(.restartButton, for: .normal)
        button.setImage(.restartButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(restartClicked), for: .touchUpInside)
        return button
    }()
    @objc func restartClicked() {
        parent.gameScene?.reset()
        parent.gameOverView.alpha = 0
    }
    
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backButton, for: .normal)
        button.setImage(.backButtonPressed, for: .highlighted)
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    @objc func backClicked() {
        parent.gameScene?.reset()
        parent.gameScene?.status = .animating
        parent.gameScene?.introNode.removeFromParent()
        parent.homeView.alpha = 1
        alpha = 0
    }

    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .kenneyFont
        label.font = label.font.withSize(52)
        label.textColor = .appBeige
        label.textAlignment = .center
        return label
    }()
    
    
    init(frame: CGRect = .zero, parent: GameViewController) {
        self.parent = parent
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .appBrown2
        layer.borderColor = UIColor.appBrown1.cgColor
        layer.borderWidth = 2
        
        setupRestartButton()
        setupBackButton()
        
    }
    
    private func setupRestartButton() {
        addSubview(restartButton)
        restartButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
