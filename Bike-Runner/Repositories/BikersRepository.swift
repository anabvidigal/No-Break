//
//  BikersRepository.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 03/02/22.
//

import Foundation

protocol BikersRepository {
    func getBikers() -> [Biker]
    func getSelectedBiker() -> Biker
    func save(bikers: [Biker])
    func reset()
}

class UserDefaultsBikersRepository: BikersRepository {
    let defaultBikers = [
        Biker(name: "James", description: "The boy is an artist", id: "fixed", price: 0, status: .selected, index: 0),
        Biker(name: "Nati", description: "She's really into dinosaurs", id: "fixie", price: 0, status: .bought, index: 1),
        Biker(name: "Carol", description: "I think she likes the president", id: "MTB", price: 150, status: .forSale, index: 2),
        Biker(name: "Gabe", description: "He loves his cats", id: "BMX", price: 500, status: .forSale, index: 3),
        Biker(name: "Oil Man", description: "What's with the swim suit tho?", id: "barra_forte", price: 1000, status: .forSale, index: 4)
    ]
    
    var playerBikers: [Biker] = []
    
    func getBikers() -> [Biker] {
        for (index, biker) in defaultBikers.enumerated() {
            guard let bikerStatus = Biker.Status(rawValue: UserDefaults.standard.integer(forKey: biker.id)) else { return defaultBikers }
            if bikerStatus == .unregistered {
                biker.status = defaultBikers[index].status
            } else {
                biker.status = bikerStatus
            }
            playerBikers.append(biker)
        }
        return playerBikers
    }
    
    func getSelectedBiker() -> Biker {
        if playerBikers.isEmpty {
            _ = getBikers()
        }
        for biker in playerBikers {
            if biker.status == .selected {
                return biker
            }
        }
        return defaultBikers.first!
    }
    
    func save(bikers: [Biker]) {
        for biker in bikers {
            UserDefaults.standard.set(biker.status.rawValue, forKey: biker.id)
        }
    }
    
    func reset() {
        for biker in defaultBikers {
            UserDefaults.standard.set(biker.status.rawValue, forKey: biker.id)
        }
    }
}
