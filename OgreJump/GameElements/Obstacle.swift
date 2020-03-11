//
//  Obstacle.swift
//  OgreJump
//
//  Created by M Cavasin on 08/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode, GameObject {
    
    
    var carnivorousPlant = SKSpriteNode(imageNamed: "greenCrystal.png")
//    var greenCrystal = SKSpriteNode(imageNamed: "bat0")
    var directionPlant: CGFloat = 0.0

    
    func setUp() {
//        let batTexture = SKTexture(imageNamed: "bat4.png")
//        greenCrystal.scale(to: CGSize(width: (greenCrystal.texture?.size().width)! * 0.2, height: (greenCrystal.texture?.size().height)! * 0.2))
//        greenCrystal.physicsBody = SKPhysicsBody(texture: batTexture, alphaThreshold: 0.8, size: CGSize(width: greenCrystal.size.width, height: greenCrystal.size.height))

                let plantTexture = SKTexture(imageNamed: "greenCrystal.png")
        carnivorousPlant.scale(to: CGSize(width: (carnivorousPlant.texture?.size().width)! * 0.5, height: (carnivorousPlant.texture?.size().height)! * 0.5))
//        carnivorousPlant.scale(to: CGSize(width: (carnivorousPlant.texture?.size().width)! * 3.0, height: (carnivorousPlant.texture?.size().height)! * 2.5))
//                greenCrystal.physicsBody = SKPhysicsBody(texture: crystalTexture, alphaThreshold: 0.8, size: CGSize(width: greenCrystal.size.width, height: greenCrystal.size.height))
        carnivorousPlant.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
//        let batScale = CGFloat(0.8)
//        greenCrystal.xScale = batScale
//        greenCrystal.yScale = batScale
        

        carnivorousPlant.physicsBody?.categoryBitMask = GameConfig.ObstacleCategory
        carnivorousPlant.physicsBody?.contactTestBitMask = GameConfig.PlayerCategory
        carnivorousPlant.physicsBody?.affectedByGravity = false
        carnivorousPlant.physicsBody?.isDynamic = false
        
        if Int.random(in: 0...1) == 0 {
            carnivorousPlant.position = CGPoint(x: GameConfig.xRightPosition + 30, y: CGFloat(1000))
//            carnivorousPlant.zRotation = GameConfig.zplantRight
            directionPlant = GameConfig.plantRight
        } else {
            carnivorousPlant.position = CGPoint(x: GameConfig.xLeftPosition - 30, y: CGFloat(1000))
//            carnivorousPlant.zRotation = GameConfig.zplantLeft
            directionPlant = GameConfig.plantLeft
        }
    }
    func update(deltaTime: TimeInterval, velocity: Double) {
        let velocity = GameConfig.backgroundSpeed //CGFloat(5.0)
            carnivorousPlant.position.y -= CGFloat(velocity) //* 

        
    }
    
    
    //MARK: Animaçao com as texturas
    
    var PlantBitingFrames: [SKTexture] = []   // array de texturas
    let BiteAnimatedAtlas = SKTextureAtlas(named: "obstaclePlant") // salvar as imagens do arquivo atlas
    func buildPlantTexture() {
        // funçao para construir o array de texturas e atribuir a textura para o player parado
        var biteFrames: [SKTexture] = []
        let numImagesBite = BiteAnimatedAtlas.textureNames.count
        
        for i in 0...(numImagesBite - 1) {
            let PlantTextureName = "plant0\(i)"
            biteFrames.append(BiteAnimatedAtlas.textureNamed(PlantTextureName))
        }
        PlantBitingFrames = biteFrames
        let firstFrameTexture = BiteAnimatedAtlas.textureNamed("plant01")
        carnivorousPlant.texture = firstFrameTexture
        self.setUp()
    }
    func animatePlayer(direction: CGFloat) {
        // função para a animação do player usando as texturas
            carnivorousPlant.xScale = abs(carnivorousPlant.xScale) * directionPlant
            carnivorousPlant.run(SKAction.repeatForever(
                SKAction.animate(with: PlantBitingFrames,
                                 timePerFrame: 0.3,
                                 resize: false,
                                 restore: true)),
                     withKey:"walkingInPlacePlayer")
    }
    
    
    
}
