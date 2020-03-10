//
//  batEnemy.swift
//  OgreJump
//
//  Created by M Cavasin on 05/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import Foundation
import SpriteKit

class BatEnemy: SKSpriteNode, GameObject {
    var bat = SKSpriteNode(imageNamed: "bat0")
    var animationIsRunnig = false // variável utilizada para evitar com que a animaçao seja executada enquanto já existe uma animaçao acontecendo
    var rightSide: Bool!
    var leftSide: Bool!
    
    func setUp() {
        let batTexture = SKTexture(imageNamed: "bat4.png")
        
        bat.scale(to: CGSize(width: (bat.texture?.size().width)! * 0.8, height: (bat.texture?.size().height)! * 0.8))
        bat.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 20))
            
            //SKPhysicsBody(texture: batTexture, alphaThreshold: 0.8, size: CGSize(width: bat.size.width, height: bat.size.height))
        
        
//        bat.physicsBody = SKPhysicsBody(texture: batTexture, alphaThreshold: 0.8, size: CGSize(width: bat.size.width, height: bat.size.height))
//        let PlayerTexture = SKTextureAtlas(named: "bat")
//        bat.physicsBody = SKPhysicsBody(texture: PlayerTexture.textureNamed("bat1"), alphaThreshold: 0.8, size: CGSize(width: bat.size.width, height: bat.size.height))
//        let batScale = CGFloat(0.8)
//        bat.xScale = batScale
//        bat.yScale = batScale

        if Int.random(in: 0...1) == 0 {
            bat.position = CGPoint(x: GameConfig.xRightPosition, y: CGFloat(1000))
            rightSide = true
        } else {
            bat.position = CGPoint(x: GameConfig.xLeftPosition, y: CGFloat(1000))
            rightSide = false
        }
        bat.physicsBody?.isDynamic = false
        bat.physicsBody?.categoryBitMask = GameConfig.EnemyCategory
        bat.physicsBody?.contactTestBitMask = GameConfig.PlayerCategory
    }
    
    func update(deltaTime: TimeInterval, velocity: Double) {
        
        
        if bat.position.y <= 50 {
            if rightSide && !animationIsRunnig {
                animationIsRunnig = true
                bat.run(jumpAnimation(x: GameConfig.xLeftPosition))
            } else if !rightSide && !animationIsRunnig {
                animationIsRunnig = true
                bat.run(jumpAnimation(x: GameConfig.xRightPosition))
            }
        } else {
            bat.position.y -= CGFloat(velocity)
        }
        
    }
    
    func jumpAnimation(x: CGFloat) -> SKAction {
        let moveX = SKAction.moveTo(x: x, duration: 2.6)
        let moveYDown1 = SKAction.moveTo(y: CGFloat(-100), duration: 0.8)
        moveYDown1.timingMode = .easeOut
        let moveYUp1 = SKAction.moveTo(y: CGFloat(-120), duration: 0.8)
        moveYUp1.timingMode = .easeIn
        let moveYDown2 = SKAction.moveTo(y: GameConfig.yPosition, duration: 0.8)
        moveYDown2.timingMode = .easeOut
        let moveX2 = SKAction.moveTo(x: x * 2, duration: 0.8)
        
        let sequence = SKAction.sequence([moveYDown1, moveYUp1, moveYDown2, moveX2])
        let group = SKAction.group([moveX, sequence])
        
        return group
    }
    
    
    
    
    //MARK: Animaçao com as texturas
    
    var BatFlyingFrames: [SKTexture] = []   // array de texturas
    let FlyAnimatedAtlas = SKTextureAtlas(named: "bat") // salvar as imagens do arquivo atlas
    func buildBatTexture() {
        // funçao para construir o array de texturas e atribuir a textura para o player parado
        var flyFrames: [SKTexture] = []
        let numImagesFly = FlyAnimatedAtlas.textureNames.count
        
        for i in 0...(numImagesFly - 1) {
            let BatTextureName = "bat\(i)"
            flyFrames.append(FlyAnimatedAtlas.textureNamed(BatTextureName))
        }
        BatFlyingFrames = flyFrames
        let firstFrameTexture = FlyAnimatedAtlas.textureNamed("bat0")
        bat.texture = firstFrameTexture
        self.setUp()
    }
    func animatePlayer(direction: CGFloat) {
        // função para a animação do player usando as texturas
            bat.xScale = abs(bat.xScale) * direction
            bat.run(SKAction.repeatForever(
                SKAction.animate(with: BatFlyingFrames,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true)),
                     withKey:"walkingInPlacePlayer")
    }
    
}
