//
//  GameConfig.swift
//  OgreJump
//
//  Created by M Cavasin on 05/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import Foundation
import SpriteKit

class GameConfig {
    static let gameSpeed: Double = 3.0
    static var backgroundSpeed: CGFloat = 5.0
    static let scorePosition = CGPoint(x: 30, y: 550)
    static let backgroundPosition = CGPoint(x: 1, y: 1)
    static let left = CGFloat(-1.0)
    static let right = CGFloat(1.0)
    static let xRightPosition = CGFloat(180)
    static let xLeftPosition = CGFloat(-180)
    static let yPosition = CGFloat(-300)
    static let yUpPosition = CGFloat(-200)
    static let zRightRotation = CGFloat(70)
    static let zLeftRotation = CGFloat(-70)
    static let zStandRotation = CGFloat(0)
    static let zObstacleRight = CGFloat(70)
    static let zObstacleLeft = CGFloat(-70)
    
    static let PlayerCategory: UInt32 = 0x1 << 0
    static let EnemyCategory: UInt32 = 0x1 << 1
    static let ObstacleCategory: UInt32 = 0x1 << 2
}

