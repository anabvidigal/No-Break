//
//  CoinsRepository.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation

protocol CoinsRepository {
    func add(coins: Int)
    func getCoins() -> Int
    func spend(coins: Int)
    func reset()
}

class UserDefaultsCoinsRepository: CoinsRepository {
    private let key = "coins"
    
    func add(coins: Int) {
        UserDefaults.standard.setValue(getCoins() + coins, forKey: key)
    }
    
    func getCoins() -> Int {
        UserDefaults.standard.integer(forKey: key)
    }
    
    func spend(coins: Int) {
        UserDefaults.standard.setValue(getCoins() - coins, forKey: key)
    }
    
    func reset() {
        UserDefaults.standard.setValue(0, forKey: key)
    }
}
