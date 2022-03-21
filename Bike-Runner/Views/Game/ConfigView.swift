//
//  ConfigView.swift
//  Bike-Runner
//
//  Created by André Schueda on 19/03/22.
//

import UIKit
import SnapKit

class ConfigView: UIView {
    weak var parent: GameViewController?
    var hapticsManager: HapticsManager?
    var soundManager: SoundManager?
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown2
        return view
    }()
    
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .kenneyFont.withSize(32)
        label.textColor = .appBeige
        return label
    }()
    
    lazy var buttonsView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var soundButton: UIButton = {
        let button = UIButton()
        button.setImage(soundManager?.soundIsOn ?? true ? .soundButtonOn : .soundButtonOff, for: .normal)
        button.setImage(soundManager?.soundIsOn ?? true ? .soundButtonOnPressed : .soundButtonOffPressed, for: .highlighted)
        button.addTarget(self, action: #selector(soundButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func soundButtonClicked() {
        guard let soundManager = soundManager else { return }
        soundManager.toggleSound()
        
        if soundManager.soundIsOn {
            soundButton.setImage(.soundButtonOn, for: .normal)
            soundButton.setImage(.soundButtonOnPressed, for: .highlighted)
            soundManager.playTapSound()
        } else {
            soundButton.setImage(.soundButtonOff, for: .normal)
            soundButton.setImage(.soundButtonOffPressed, for: .highlighted)
        }
    }
    
    lazy var soundLabel: UILabel = {
        let label = UILabel()
        label.text = "Sound"
        label.font = .kenneyFont.withSize(15)
        label.textColor = .appBeige
        return label
    }()
    
    lazy var musicButton: UIButton = {
        let button = UIButton()
        button.setImage(soundManager?.soundIsOn ?? true ? .musicButtonOn : .musicButtonOff, for: .normal)
        button.setImage(soundManager?.soundIsOn ?? true ? .musicButtonOnPressed : .musicButtonOffPressed, for: .highlighted)
        button.addTarget(self, action: #selector(musicButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func musicButtonClicked() {
        guard let soundManager = soundManager else { return }
        soundManager.toggleMusic()
        
        if soundManager.musicIsOn {
            musicButton.setImage(.musicButtonOn, for: .normal)
            musicButton.setImage(.musicButtonOnPressed, for: .highlighted)
        } else {
            musicButton.setImage(.musicButtonOff, for: .normal)
            musicButton.setImage(.musicButtonOffPressed, for: .highlighted)
        }
    }
    
    lazy var musicLabel: UILabel = {
        let label = UILabel()
        label.text = "Music"
        label.font = .kenneyFont.withSize(15)
        label.textColor = .appBeige
        return label
    }()
    
    lazy var vibrationButton: UIButton = {
        let button = UIButton()
        button.setImage(hapticsManager?.vibrationIsOn ?? true ? .vibrationButtonOn : .vibrationButtonOff, for: .normal)
        button.setImage(hapticsManager?.vibrationIsOn ?? true ? .vibrationButtonOnPressed : .vibrationButtonOffPressed, for: .highlighted)
        button.addTarget(self, action: #selector(vibrationButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func vibrationButtonClicked() {
        guard let hapticsManager = hapticsManager else { return }
        hapticsManager.toggleVibration()
        
        if hapticsManager.vibrationIsOn {
            vibrationButton.setImage(.vibrationButtonOn, for: .normal)
            vibrationButton.setImage(.vibrationButtonOnPressed, for: .highlighted)
            hapticsManager.catchCoinVibrate()
        } else {
            vibrationButton.setImage(.vibrationButtonOff, for: .normal)
            vibrationButton.setImage(.vibrationButtonOffPressed, for: .highlighted)
        }
    }
    
    lazy var vibrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Vibration"
        label.font = .kenneyFont.withSize(15)
        label.textColor = .appBeige
        return label
    }()
    
    lazy var developedLabel: UILabel = {
        let label = UILabel()
        label.text = "Developed by"
        label.font = .kenneyFont.withSize(15)
        label.textColor = .appGray
        return label
    }()
    
    lazy var developersLabel: UILabel = {
        let label = UILabel()
        label.text = "Ana Bittencourt and Andre Schueda"
        label.font = .kenneyFont.withSize(12)
        label.textColor = .appGray
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backButton, for: .normal)
        button.setImage(.backButtonPressed, for: .normal)
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    @objc func backButtonClicked() {
        parent?.hideConfig()
        soundManager?.playTapSound()
    }
    
    init(frame: CGRect = .zero, parent: GameViewController, hapticsManager: HapticsManager?, soundManager: SoundManager?) {
        self.parent = parent
        self.hapticsManager = hapticsManager
        self.soundManager = soundManager
        super.init(frame: frame)
        
        setupContentView()
        setupSettingsLabel()
        
        setupButtonsView()
        setupSoundButton()
        setupSoundLabel()
        setupMusicButton()
        setupMusicLabel()
        setupVibrationButton()
        setupVibrationLabel()
        
        setupDevelopersLabel()
        setupDevelopedLabel()
        
        setupBackButton()
    }
    
    private func setupContentView() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(250)
            make.center.equalToSuperview()
        }
    }
    
    private func setupSettingsLabel() {
        contentView.addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupButtonsView() {
        contentView.addSubview(buttonsView)
        buttonsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupSoundButton() {
        buttonsView.addSubview(soundButton)
        soundButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func setupSoundLabel() {
        buttonsView.addSubview(soundLabel)
        soundLabel.snp.makeConstraints { make in
            make.top.equalTo(soundButton.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(soundButton)
        }
    }
    
    private func setupMusicButton() {
        buttonsView.addSubview(musicButton)
        musicButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.leading.equalTo(soundButton.snp.trailing).offset(40)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupMusicLabel() {
        buttonsView.addSubview(musicLabel)
        musicLabel.snp.makeConstraints { make in
            make.top.equalTo(musicButton.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(musicButton)
        }
    }
    
    private func setupVibrationButton() {
        buttonsView.addSubview(vibrationButton)
        vibrationButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(soundButton.snp.leading).offset(-40)
        }
    }
    
    private func setupVibrationLabel() {
        buttonsView.addSubview(vibrationLabel)
        vibrationLabel.snp.makeConstraints { make in
            make.top.equalTo(vibrationButton.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(vibrationButton)
        }
    }
    
    private func setupDevelopersLabel() {
        contentView.addSubview(developersLabel)
        developersLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupDevelopedLabel() {
        contentView.addSubview(developedLabel)
        developedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(developersLabel.snp.top)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.leading).offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
