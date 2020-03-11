//
//  Player.swift
//  OgreJump
//
//  Created by M Cavasin on 04/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//


import SpriteKit

class Player: SKSpriteNode {
    
    var control: Int! // variável para controle da posição do Player
    var jump: Bool! // variável para controle do pulo do Player
    var hasDied: Bool! // variável para controle da morte do Player
    
    func setUp() {
        
        //        let CanoingTexture = SKTexture(imageNamed: "0_Ogre_Idle_000.png")
        //
        //        self.scale(to: CGSize(width: (self.texture?.size().width)! * 0.2, height: (self.texture?.size().height)! * 0.2))
        //        self.physicsBody = SKPhysicsBody(texture: CanoingTexture, alphaThreshold: 0.8, size: CGSize(width: self.size.width + 20, height: self.size.height + 20))
        
        //        let PlayerTexture = SKTexture(imageNamed: "0_Ogre_Idle_000.png")
        //        self.scale(to: CGSize(width: (self.texture?.size().width)! * 0.2, height: (self.texture?.size().height)! * 0.2))
        //        self.physicsBody = SKPhysicsBody(texture: PlayerTexture, alphaThreshold: 0.8, size: CGSize(width: self.size.width, height: self.size.height))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        
        self.position = CGPoint(x: CGFloat(GameConfig.xRightPosition), y: CGFloat(GameConfig.yPosition))
        self.zRotation = CGFloat(GameConfig.zRightRotation)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody!.isDynamic = true
        self.physicsBody!.allowsRotation = true
        self.physicsBody?.pinned = false
        self.physicsBody?.categoryBitMask = GameConfig.PlayerCategory
        self.physicsBody?.contactTestBitMask = GameConfig.EnemyCategory | GameConfig.ObstacleCategory
        self.control = 0
        self.jump = false
        self.hasDied = false
        
    }
    
    
    
    
    func jumpAnimation(x: CGFloat) -> SKAction {
        let moveX = SKAction.moveTo(x: x, duration: 0.50)
        let moveYUp = SKAction.moveTo(y: GameConfig.yUpPosition, duration: 0.25)
        moveYUp.timingMode = .easeOut
        let moveYDown = SKAction.moveTo(y: GameConfig.yPosition, duration: 0.25)
        moveYDown.timingMode = .easeIn
        let sequence = SKAction.sequence([moveYUp, moveYDown])
        let group = SKAction.group([moveX, sequence])
        return group
    }
    
    func jumpPlayer() {
        
        if control == 0 {
            jump = true
            control = 1
            self.zRotation = CGFloat(GameConfig.zStandRotation)
            animatePlayer(direction: GameConfig.left)
            self.run(jumpAnimation(x: GameConfig.xLeftPosition)){
                self.jump = false
                self.zRotation = CGFloat(GameConfig.zLeftRotation)
                self.animatePlayer(direction: GameConfig.left)
            }
        } else if control == 1 {
            jump = true
            control = 0
            self.zRotation = CGFloat(GameConfig.zStandRotation)
            animatePlayer(direction: GameConfig.right)
            self.run(jumpAnimation(x: GameConfig.xRightPosition)){
                self.jump = false
                self.zRotation = CGFloat(GameConfig.right)
                self.animatePlayer(direction: GameConfig.right)
            }
        }
    }
    
    
    func dyingAnimation(x: CGFloat) -> SKAction {
        let moveX = SKAction.moveTo(x: x, duration: 0.50)
        let moveYUp = SKAction.moveTo(y: GameConfig.yUpPosition, duration: 0.25)
        moveYUp.timingMode = .easeOut
        let moveYDown = SKAction.moveTo(y: GameConfig.yPosition, duration: 0.25)
        moveYDown.timingMode = .easeIn
        let sequence = SKAction.sequence([moveYUp, moveYDown])
        let group = SKAction.group([moveX, sequence])
        return group
    }
    
    func deadPlayer() {
        if control == 0 {
            hasDied = true
            control = 0
            self.zRotation = CGFloat(GameConfig.zStandRotation)
            animatePlayer(direction: GameConfig.right)
            self.run(dyingAnimation(x: GameConfig.xDiedPosition)){
                self.hasDied = false
            }
        } else if control == 1 {
            hasDied = true
            control = 0
            self.zRotation = CGFloat(GameConfig.zStandRotation)
            animatePlayer(direction: GameConfig.left)
            self.run(dyingAnimation(x: GameConfig.xDiedPosition)){
                self.hasDied = false
            }
        }
    }
    
    
    
    
    //MARK: Animaçao com as texturas
    
    var PlayerWalkingFrames: [SKTexture] = []   // array de texturas
    var PlayerJumpingFrames: [SKTexture] = []   // array de texturas
    var PlayerDyingFrames: [SKTexture] = []
    let WalkAnimatedAtlas = SKTextureAtlas(named: "WalkingPlayer") // salvar as imagens do arquivo atlas
    let JumpAnimatedAtlas = SKTextureAtlas(named: "SlashinginTheAir")
    let DiedAnimatedAtlas = SKTextureAtlas(named: "Dying")
    
    func buildPlayerTexture() {
        // funçao para construir o array de texturas e atribuir a textura para o player parado
        var walkFrames: [SKTexture] = []
        var jumpFrames: [SKTexture] = []
        var dieFrames: [SKTexture] = []
        let numImagesWalk = WalkAnimatedAtlas.textureNames.count
        for i in 0...(numImagesWalk - 1) {
            if i < 10 {
                let PlayerTextureName = "0_Ogre_Walking_00\(i)"
                walkFrames.append(WalkAnimatedAtlas.textureNamed(PlayerTextureName))
                let PlayerJumpName = "0_Ogre_Slashing%20in%20The%20Air_00\(i)"
                jumpFrames.append(JumpAnimatedAtlas.textureNamed(PlayerJumpName))
                let PlayerDiedName = "0_Ogre_Dying_00\(i)"
                dieFrames.append(DiedAnimatedAtlas.textureNamed(PlayerDiedName))
                
            } else {
                let PlayerTextureName = "0_Ogre_Walking_0\(i)"
                walkFrames.append(WalkAnimatedAtlas.textureNamed(PlayerTextureName))
                if i < 12 {
                    let PlayerJumpName = "0_Ogre_Slashing%20in%20The%20Air_0\(i)"
                    jumpFrames.append(JumpAnimatedAtlas.textureNamed(PlayerJumpName))
                    let PlayerDiedName = "0_Ogre_Dying_0\(i)"
                    dieFrames.append(DiedAnimatedAtlas.textureNamed(PlayerDiedName))
                } else if i < 15 {
                    // refazendo até o 15 somente no else para poupar processamento
                    let PlayerDiedName = "0_Ogre_Dying_0\(i)"
                    dieFrames.append(DiedAnimatedAtlas.textureNamed(PlayerDiedName))
                    
                }
            }
        }
        PlayerWalkingFrames = walkFrames
        PlayerJumpingFrames = jumpFrames
        PlayerDyingFrames = dieFrames
        let firstFrameTexture = WalkAnimatedAtlas.textureNamed("0_Ogre_Walking_000")
        self.texture = firstFrameTexture
        self.setUp()
    }
    
    func animatePlayer(direction: CGFloat) {
        // função para a animação do player usando as texturas
        if jump {
            self.xScale = abs(self.xScale) * direction
            self.run(SKAction.repeatForever(
                SKAction.animate(with: PlayerJumpingFrames,
                                 timePerFrame: 0.04,
                                 resize: false,
                                 restore: true)),
                     withKey:"walkingInPlacePlayer")
        } else if hasDied {
            self.xScale = abs(self.xScale) * direction
            self.run(SKAction.animate(with: PlayerDyingFrames,
                             timePerFrame: 0.08,
                             resize: false,
                             restore: true),
                 withKey:"walkingInPlacePlayer")
        } else {
            self.xScale = abs(self.xScale) * direction
            self.run(SKAction.repeatForever(
                SKAction.animate(with: PlayerWalkingFrames,
                                 timePerFrame: 0.02,
                                 resize: false,
                                 restore: true)),
                     withKey:"walkingInPlacePlayer")
        }
    }
    
    
    
    
    
    
}
