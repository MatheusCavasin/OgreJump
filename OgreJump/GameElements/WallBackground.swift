//
//  Background.swift
//  OgreJump
//
//  Created by M Cavasin on 03/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import Foundation
import SpriteKit


class WallBackground: GameObject {
    
    let node: SKNode
    let wallTileSize = CGFloat(128)
    
    init(node: SKNode) {
        self.node = node
        //setAnimation()
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        let velY = CGFloat(5.0) //CGFloat(velocity) usar o velocity para velocidade varável do background
        node.position.y -= velY
        
        if node.position.y < wallTileSize {
            node.position.y += wallTileSize
        }
        
    }
    
    // Função usada para animar o background na horizontal
    /* func setAnimation() {
        if let background = node.childNode(withName: "AnimationNode") {
            
            let range = CGFloat(210.0)
            let moveBackground = SKAction.moveBy(x: range, y: 0, duration: 5)
            moveBackground.timingMode = .easeInEaseOut
            let moveBackgroundBack = SKAction.moveBy(x: -range, y: 0, duration: 5)
            moveBackgroundBack.timingMode = .easeInEaseOut
            let sequence = SKAction.sequence([moveBackground, moveBackgroundBack])
            background.run(SKAction.repeatForever(sequence))
            
        }
        else {
            fatalError("node should have a child named background")
        }
        
    } */
    
}
