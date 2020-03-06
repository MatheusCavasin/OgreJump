//
//  GameObject.swift
//  OgreJump
//
//  Created by M Cavasin on 03/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import Foundation

protocol GameObject {
    
    func update(deltaTime: TimeInterval, velocity: Double)
    
}
