//
//  Biker.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import Foundation

class Biker {
    var id: String
    var name: String
    var description: String
    var price: Int
    var status: Status
    
    init(name: String, description: String, id: String, price: Int, status: Status) {
        self.name = name
        self.description = description
        self.id = id
        self.price = price
        self.status = status
    }
    
    enum Status: Int {
        case unregistered
        case selected
        case bought
        case forSale
    }
}
