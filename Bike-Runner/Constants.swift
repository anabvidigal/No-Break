//
//  Masks.swift
//  Bike-Runner
//
//  Created by Ana Bittencourt Vidigal on 31/01/22.
//

import Foundation
import SpriteKit

class Constants {
    
    
    // bike
    static let bikeTopLaneCategory: UInt32 = 0x00000001
    static let bikeBottomLaneCategory: UInt32 = 0x00000010
    
    static let bikeTopLaneContact: UInt32 = 0x10000000
    static let bikeBottomLaneContact: UInt32 = 0x01000000
    
    static let bikeCollision: UInt32 = 0

    
    // car
    static let carTopLaneCategory: UInt32 = 0x00000100
    static let carBottomLaneCategory: UInt32 = 0x00001000
    
    static let carTopLaneContact: UInt32 = 0x00000001
    static let carBottomLaneContact: UInt32 = 0x00000010
    
    static let carCollision: UInt32 = 0

    
    // coin
    static let coinTopLaneCategory: UInt32 = 0x10000000
    static let coinBottomLaneCategory: UInt32 = 0x01000000
    
    static let coinCollision: UInt32 = 0
    
    
    // score
    static let scoreDetectorContact: UInt32 = 0x00001100
    static let scoreDetectorCollision: UInt32 = 0
    
    
    // coin
    // 0...100
    static let coinRate = 40
    
    
    static let scenerySpeed = CGFloat(0.2)
    
    static let gameSceneLeftEdge = CGFloat(-768)
    static let gameSceneRightEdge = CGFloat(768)
    
    static let roadAngle = CGFloat(-15)
    
}
