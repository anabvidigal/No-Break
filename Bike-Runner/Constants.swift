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
    
    static let bikeBottomLane = CGFloat(-74)
    static let bikeTopLane = CGFloat(-24)
    
    static let carBottomLane = CGFloat(-534)
    static let carTopLane = CGFloat(-488)
    
    // ads
    static let interstitialAdUnitID: String = "ca-app-pub-6812178981373996/7920800585"
    static let rewardedAdUnitID: String = "ca-app-pub-6812178981373996/7900920601"
    
    static let testInterstitialAdUnitID: String = "ca-app-pub-3940256099942544/4411468910"
    static let testRewardedAdUnitID: String = "ca-app-pub-3940256099942544/1712485313"

    
}
