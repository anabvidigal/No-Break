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
    var showingBiker: Biker
    var showingIndex: Int
    
    init(bikersRepository: BikersRepository) {
        self.bikersRepository = bikersRepository
        bikers = bikersRepository.getBikers()
        selectedBiker = bikersRepository.getSelectedBiker()
        showingBiker = selectedBiker
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
            showingBiker = bikers[showingIndex]
            return showingBiker
        }
        showingIndex = 0
        showingBiker = bikers[showingIndex]
        return showingBiker
    }
    
    func getPreviousBiker() -> Biker {
        bikersRepository.reset()
        showingIndex -= 1
        if showingIndex >= 0 {
            showingBiker = bikers[showingIndex]
            return showingBiker
        }
        showingIndex = bikers.count - 1
        showingBiker = bikers[showingIndex]
        return showingBiker
    }
    
    func selectShowingBiker() {
        let unselectedBiker = selectedBiker
        unselectedBiker.status = .bought
        bikers[selectedBiker.index] = unselectedBiker
        
        showingBiker.status = .selected
        bikers[showingIndex] = showingBiker
        
        bikersRepository.save(bikers: bikers)
        
        selectedBiker = showingBiker
    }
}
