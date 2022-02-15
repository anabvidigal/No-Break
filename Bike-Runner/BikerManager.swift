//
//  BikeManager.swift
//  Bike-Runner
//
//  Created by André Schueda on 14/02/22.
//

import Foundation

class BikerManager {
    private var bikersRepository: BikersRepository
    
    var bikers: [Biker] = []
    var selectedBiker: Biker
    var showingIndex: Int = 0
    
    init(bikersRepository: BikersRepository) {
        self.bikersRepository = bikersRepository
        bikers = bikersRepository.getBikers()
        selectedBiker = bikersRepository.getSelectedBiker()
        showingIndex = selectedBiker.index
    }
    
    func getBikers() -> [Biker] {
        if bikers.isEmpty {
            bikers = bikersRepository.getBikers()
            return bikers
        }
        return bikers
    }
    
    func getNextBiker() -> Biker {
        showingIndex += 1
        if showingIndex < bikers.count {
            return bikers[showingIndex]
        }
        showingIndex = 0
        return bikers[showingIndex]
    }
    
    func getPreviousBiker() -> Biker {
        showingIndex -= 1
        if showingIndex >= 0 {
            return bikers[showingIndex]
        }
        showingIndex = bikers.count - 1
        return bikers[showingIndex]
    }
    
    func selectBiker() {
        let unselectedBiker = selectedBiker
        unselectedBiker.status = .bought
        bikers[selectedBiker.index] = unselectedBiker
        
        let newSelectedBiker = bikers[showingIndex]
        newSelectedBiker.status = .selected
        bikers[showingIndex] = newSelectedBiker
        
        bikersRepository.save(bikers: bikers)
        
        selectedBiker = newSelectedBiker
    }
}
