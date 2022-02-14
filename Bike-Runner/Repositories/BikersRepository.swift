//
//  BikersRepository.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation

protocol BikersRepository {
    func getBikers() -> [Biker]
    func save(bikers: [Biker])
    func getSelectedBiker() -> Biker
}

class UserDefaultsBikersRepository: BikersRepository {
    func getBikers() -> [Biker] {
        return []
    }
    
    func save(bikers: [Biker]) {
    }
    
    func getSelectedBiker() -> Biker {
        return Biker(name: "James", description: "The boy is an artist, you know?", imagesId: "fixed", price: 0, status: .selected)
    }
}
