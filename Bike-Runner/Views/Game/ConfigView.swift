//
//  ConfigView.swift
//  Bike-Runner
//
//  Created by André Schueda on 19/03/22.
//

import UIKit

class ConfigView: UIView {
    var hapticsManager: HapticsManager
    var soundManager: SoundManager
    
    init(frame: CGRect = .zero, hapticsManager: HapticsManager, soundManager: SoundManager) {
        self.hapticsManager = hapticsManager
        self.soundManager = soundManager
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
