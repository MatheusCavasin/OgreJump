//
//  Obstacle.swift
//  OgreJump
//
//  Created by M Cavasin on 08/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode, GameObject {
    
    
    var greenCrystal = SKSpriteNode(imageNamed: "greenCrystal.png")
//    var greenCrystal = SKSpriteNode(imageNamed: "bat0")

    
    func setUp() {
//        let batTexture = SKTexture(imageNamed: "bat4.png")
//        greenCrystal.scale(to: CGSize(width: (greenCrystal.texture?.size().width)! * 0.2, height: (greenCrystal.texture?.size().height)! * 0.2))
//        greenCrystal.physicsBody = SKPhysicsBody(texture: batTexture, alphaThreshold: 0.8, size: CGSize(width: greenCrystal.size.width, height: greenCrystal.size.height))

                let crystalTexture = SKTexture(imageNamed: "greenCrystal.png")
        greenCrystal.scale(to: CGSize(width: (greenCrystal.texture?.size().width)! * 3.0, height: (greenCrystal.texture?.size().height)! * 2.5))
//                greenCrystal.physicsBody = SKPhysicsBody(texture: crystalTexture, alphaThreshold: 0.8, size: CGSize(width: greenCrystal.size.width, height: greenCrystal.size.height))
        greenCrystal.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
//        let batScale = CGFloat(0.8)
//        greenCrystal.xScale = batScale
//        greenCrystal.yScale = batScale
        

        greenCrystal.physicsBody?.categoryBitMask = GameConfig.ObstacleCategory
        greenCrystal.physicsBody?.contactTestBitMask = GameConfig.PlayerCategory
        greenCrystal.physicsBody?.affectedByGravity = false
        greenCrystal.physicsBody?.isDynamic = false
        
        if Int.random(in: 0...1) == 0 {
            greenCrystal.position = CGPoint(x: GameConfig.xRightPosition + 30, y: CGFloat(1000))
            greenCrystal.zRotation = GameConfig.zObstacleRight
        } else {
            greenCrystal.position = CGPoint(x: GameConfig.xLeftPosition - 30, y: CGFloat(1000))
            greenCrystal.zRotation = GameConfig.zObstacleLeft
        }
    }
    func update(deltaTime: TimeInterval, velocity: Double) {
        let velocity = CGFloat(5.0)
        greenCrystal.position.y -= CGFloat(velocity)
    }
    
}
