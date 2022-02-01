//
//  Masks.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 31/01/22.
//

import Foundation
import SpriteKit

class Constants {
    
    static let bikeTopLaneCategory: UInt32 = 0x00000001
    static let bikeBottomLaneCategory: UInt32 = 0x00000010
    
    static let carTopLaneCategory: UInt32 = 0x00000100
    static let carBottomLaneCategory: UInt32 = 0x00001000
    
    
    static let carTopLaneContact: UInt32 = bikeTopLaneCategory
    static let carBottomLaneContact: UInt32 = bikeBottomLaneCategory
    
    static let bikeCollision: UInt32 = 0
    static let carCollision: UInt32 = 0
    
    static let scenerySpeed = CGFloat(0.2)
    
    static let gameSceneLeftEdge = CGFloat(-768)
    static let gameSceneRightEdge = CGFloat(768)
    
    static let roadAngle = CGFloat(-15)
}
