//
//  Player.swift
//  OgreJump
//
//  Created by M Cavasin on 04/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//


import SpriteKit

class Player: SKSpriteNode {
    
    var control: Int = 0 // variável para controle da posição do Player
    var jump = false // variável para controle do pulo do Player
    
    func setUp() {
        self.position = CGPoint(x: CGFloat(180), y: CGFloat(-300))
        self.zRotation = CGFloat(70)
        
    }
    
    

    
    
    func jumpPlayer() {
        
        if control == 0 {
            jump = true
            self.zRotation = CGFloat(0)
            animatePlayer(direction: -1.0)
            let moveX = SKAction.moveTo(x: CGFloat(-180), duration: 0.50)
            let moveYUp = SKAction.moveTo(y: CGFloat(-200), duration: 0.25)
            moveYUp.timingMode = .easeOut
            let moveYDown = SKAction.moveTo(y: CGFloat(-300), duration: 0.25)
            moveYDown.timingMode = .easeIn
            let sequence = SKAction.sequence([moveYUp, moveYDown])
            let group = SKAction.group([moveX, sequence])
            self.run(group){
                self.jump = false
                self.zRotation = CGFloat(-70)
                self.animatePlayer(direction: -1.0)
            }
            control = 1
        } else if control == 1 {
            jump = true
            self.zRotation = CGFloat(0)
            animatePlayer(direction: 1.0)
            let moveX = SKAction.moveTo(x: CGFloat(180), duration: 0.50)
            let moveYUp = SKAction.moveTo(y: CGFloat(-200), duration: 0.25)
            moveYUp.timingMode = .easeOut
            let moveYDown = SKAction.moveTo(y: CGFloat(-300), duration: 0.25)
            moveYDown.timingMode = .easeIn
            let sequence = SKAction.sequence([moveYUp, moveYDown])
            let group = SKAction.group([moveX, sequence])
            self.run(group){
                self.jump = false
                self.zRotation = CGFloat(70)
                self.animatePlayer(direction: 1.0)
            }
            
            control = 0
        }
    }
    
    
    func jumpAnimation(x: CGFloat, yUp: CGFloat) {
        let moveX = SKAction.moveTo(x: CGFloat(180), duration: 0.50)
        let moveYUp = SKAction.moveTo(y: CGFloat(-200), duration: 0.25)
        moveYUp.timingMode = .easeOut
        let moveYDown = SKAction.moveTo(y: CGFloat(-300), duration: 0.25)
        moveYDown.timingMode = .easeIn
        let sequence = SKAction.sequence([moveYUp, moveYDown])
        let group = SKAction.group([moveX, sequence])
    }
    
    
    
    //MARK: Animaçao com as texturas
    
    var PlayerWalkingFrames: [SKTexture] = []   // array de texturas
    var PlayerJumpingFrames: [SKTexture] = []   // array de texturas
    let WalkAnimatedAtlas = SKTextureAtlas(named: "WalkingPlayer") // salvar as imagens do arquivo atlas
    let JumpAnimatedAtlas = SKTextureAtlas(named: "SlashinginTheAir") // salvar as imagens do arquivo atlas
    
    func buildPlayerTexture() {
        // funçao para construir o array de texturas e atribuir a textura para o player parado
        var walkFrames: [SKTexture] = []
        var jumpFrames: [SKTexture] = []
        let numImagesWalk = WalkAnimatedAtlas.textureNames.count
        print(JumpAnimatedAtlas)
        
        for i in 0...(numImagesWalk - 1) {
            if i < 10 {
                let PlayerTextureName = "0_Ogre_Walking_00\(i)"
                walkFrames.append(WalkAnimatedAtlas.textureNamed(PlayerTextureName))
                if i < 10 {
                    let PlayerTextureName = "0_Ogre_Slashing%20in%20The%20Air_00\(i)"
                    jumpFrames.append(JumpAnimatedAtlas.textureNamed(PlayerTextureName))
                    print(jumpFrames)
                }
            } else {
                var PlayerTextureName = "0_Ogre_Walking_0\(i)"
                walkFrames.append(WalkAnimatedAtlas.textureNamed(PlayerTextureName))
                if i == 11 {
                    let PlayerTextureName = "0_Ogre_Slashing%20in%20The%20Air_0\(i)"
                    jumpFrames.append(JumpAnimatedAtlas.textureNamed(PlayerTextureName))
                }
            }
        }
        PlayerWalkingFrames = walkFrames
        PlayerJumpingFrames = jumpFrames
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
        }else{
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
