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
    private var selectedBiker: Biker
    var showingBiker: Biker
    
    init(repository: BikersRepository) {
        self.repository = repository
        bikers = repository.getBikers()
        selectedBiker = repository.getSelectedBiker()
        showingBiker = selectedBiker
    }
    
    func getBikers() -> [Biker] {
        if bikers.isEmpty {
            bikers = repository.getBikers()
            return bikers
        }
        return bikers
    }
    
    func selectShowingBiker() {
        let unselectedBiker = selectedBiker
        unselectedBiker.status = .bought
        
        showingBiker.status = .selected
        
        repository.save(bikers: bikers)
        
        selectedBiker = showingBiker
    }
    
    func getSelectedBiker() -> Biker {
        return selectedBiker
    }
    
    func setShowing(biker: Biker) {
        showingBiker = biker
    }
}
