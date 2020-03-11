//
//  SpawningObstacle.swift
//  OgreJump
//
//  Created by M Cavasin on 08/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import SpriteKit

class SpawningObstacle: GameObject {
    
    var obstacleArray: [Obstacle] = []
    var timer: TimeInterval = 0
    var node: SKNode
    var distance = 1000.0
    
    init(node: SKNode) {
        self.node = node
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        timer -= deltaTime
        
        if timer <= 0 {
            spawn()
            //calcula o tempo para criar o novo obstaculo para que a distancia se mantenha a msm
            //multiplica a velocidade em pixels/frame por 60 para virar pixels/segundo
            timer = distance/(velocity*60)
        }
        for obstacle in obstacleArray {
            obstacle.update(deltaTime: deltaTime, velocity: velocity)
            if obstacle.position.y == -640{
                obstacleArray.remove(at: 0)
                obstacle.carnivorousPlant.removeFromParent()
            }
        }
    }
    
    func destroySpawn() {
        for obstacle in obstacleArray {
            obstacle.carnivorousPlant.removeFromParent()
        }
    }
    
    func spawn() {
        let newObstacle = Obstacle()
        newObstacle.buildPlantTexture()
        newObstacle.animatePlayer(direction: 1.0)
        obstacleArray.append(newObstacle)
        node.addChild(newObstacle.carnivorousPlant)
    }
    
}
