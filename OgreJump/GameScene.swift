//
//  GameScene.swift
//  OgreJump
//
//  Created by M Cavasin on 03/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var wallBackgroundNode: SKNode!
    var gameObjects = [GameObject]()
    var lastTimeUpdate: TimeInterval = 0
    var gameVel: Double = 6.0
    var player: Player!
    var control: Int = 0 // variável para controle da posição do Player
    var jump = false // variável para controle do pulo do Player
    var backgroundScene = SKSpriteNode(imageNamed: "forest4")
    
    override func didMove(to view: SKView) {
        wallBackgroundNode = childNode(withName: "wallBackgroundNode")
        player = childNode(withName: "Player") as? Player
        player.buildPlayerTexture()
        player.animatePlayer(direction: 1.0)
        let wallBackground = WallBackground(node: wallBackgroundNode)
        gameObjects.append(wallBackground)
        backgroundScene.zPosition = -1
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.size.width = backgroundScene.size.width * 1
        backgroundScene.size.height = backgroundScene.size.height * 1
        addChild(backgroundScene)
//        animatePlayer(direction: 1.0)
            }
    
    
    func touchDown(atPoint pos : CGPoint) {
        player.jumpPlayer()
//        if control == 0 {
//            jump = true
//            player.zRotation = CGFloat(0)
//            animatePlayer(direction: -1.0)
//            player.run(SKAction.moveTo(x: CGFloat(-160), duration: 0.50)){
//                self.jump = false
//                self.player.zRotation = CGFloat(-90)
//                self.animatePlayer(direction: -1.0)
//            }
//            control = 1
//        } else if control == 1 {
//            jump = true
//            player.zRotation = CGFloat(0)
//            animatePlayer(direction: 1.0)
//            player.run(SKAction.moveTo(x: CGFloat(152), duration: 0.50)){
//                self.jump = false
//                self.player.zRotation = CGFloat(90)
//                self.animatePlayer(direction: 1.0)
//            }
//
//            control = 0
//        }
        }
    
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    /*
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
        player.texture = firstFrameTexture
    }
    func animatePlayer(direction: CGFloat) {
        // função para a animação do player usando as texturas
        if jump {
            player.xScale = abs(player.xScale) * direction
            player.run(SKAction.repeatForever(
                SKAction.animate(with: PlayerJumpingFrames,
                                 timePerFrame: 0.04,
                                 resize: false,
                                 restore: true)),
                       withKey:"walkingInPlacePlayer")
        }else{
            player.xScale = abs(player.xScale) * direction
            player.run(SKAction.repeatForever(
                SKAction.animate(with: PlayerWalkingFrames,
                                 timePerFrame: 0.04,
                                 resize: false,
                                 restore: true)),
                       withKey:"walkingInPlacePlayer")
        }
    }
    
    
    
    */
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if lastTimeUpdate == 0 {
            lastTimeUpdate = currentTime
            return
        }
        var deltaTime = currentTime - lastTimeUpdate
        lastTimeUpdate = currentTime
        
        for gameObject in gameObjects {
            gameObject.update(deltaTime: deltaTime, velocity: gameVel)
        }
        
        // funcao para aumentar velocidade do jogo, calibrar para ajustar a dificuldade
        if deltaTime < 0.05 {
            gameVel += deltaTime/8
        }
        
    }
}
