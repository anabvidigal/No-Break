//
//  BikeManager.swift
//  Bike-Runner
//
//  Created by André Schueda on 14/02/22.
//

import Foundation

class BikerManager {
    private var repository: BikersRepository
    
    var bikers: [Biker] = []
    var selectedBiker: Biker
    var showingBiker: Biker
    var showingIndex: Int
    
    init(repository: BikersRepository) {
        self.repository = repository
        bikers = repository.getBikers()
        selectedBiker = repository.getSelectedBiker()
        showingBiker = selectedBiker
        showingIndex = selectedBiker.index
    }
    
    func getBikers() -> [Biker] {
        if bikers.isEmpty {
            bikers = repository.getBikers()
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
        repository.reset()
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
        
        repository.save(bikers: bikers)
        
        selectedBiker = showingBiker
    }
}
