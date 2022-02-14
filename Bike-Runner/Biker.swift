//
//  Biker.swift
//  Bike-Runner
//
//  Created by André Schueda on 13/02/22.
//

import Foundation

class Biker {
    var name: String
    var description: String
    var imagesId: String
    var price: Int
    var status: BikerStatus
    
    init(name: String, description: String, imagesId: String, price: Int, status: BikerStatus) {
        self.name = name
        self.description = description
        self.imagesId = imagesId
        self.price = price
        self.status = status
    }
    
    enum BikerStatus {
        case bought
        case selected
        case forSale
    }
}
