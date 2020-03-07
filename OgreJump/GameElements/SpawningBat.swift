//
//  SpawningBat.swift
//  OgreJump
//
//  Created by M Cavasin on 06/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import SpriteKit

class SpawningBat: GameObject {
    
    var batArray: [BatEnemy] = []
    var timer: TimeInterval = 0
    var node: SKNode
    var distance = 500.0
    
    
    init(node: SKNode) {
        self.node = node
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        timer -= deltaTime
        
        if timer <= 0 {
            spawn()
            //calcula o tempo para criar nova pedra, para que a distancia se mantenha a msm
            //multiplica a velocidade em pixels/frame por 60 para virar pixels/segundo
            timer = distance/(velocity*60)
        }
        for bat in batArray {
            bat.update(deltaTime: deltaTime, velocity: velocity)
            
            if bat.bat.position.y <= -650 {
                batArray.remove(at: 0)
                bat.bat.removeFromParent()
            }
        }
    }
    
    func spawn() {
        let newBat = BatEnemy()
        newBat.buildBatTexture()
        newBat.animatePlayer(direction: GameConfig.right)
        batArray.append(newBat)
        node.addChild(newBat.bat)
    }
    
    
}
