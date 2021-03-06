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
    var gameVel = GameConfig.gameSpeed
    var player: Player!
    var spawnBat: SpawningBat!
    var spawnObstacle: SpawningObstacle!
    var currentDistance: SKLabelNode!
    var tapPlay: SKLabelNode!
    var distance: Double = 0.0
    var finalDistance: Double = 0.0
    var hasDied = false
    var ogreJump: SKSpriteNode!
    var tapToPlay: SKSpriteNode!
//    let highScore = GameConfig.defaults.double(forKey: "HighScore")
    
    
    var control: Int = 0 // variável para controle da posição do Player
    var jump = false // variável para controle do pulo do Player
    
    var backgroundScene0 = SKSpriteNode(imageNamed: "level0_background")
    var backgroundScene1 = SKSpriteNode(imageNamed: "level01_background")
    var backgroundScene2 = SKSpriteNode(imageNamed: "level02_background")
    var backgroundScene3 = SKSpriteNode(imageNamed: "level03_background")
    var backgroundScene4 = SKSpriteNode(imageNamed: "level04_background")
    var backgroundScene5 = SKSpriteNode(imageNamed: "sky_background")
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        /*ogreImageView.image = ogreJump
        ogreImageView.frame = CGRect(x: self.frame.midX + 20.0, y: self.frame.midX + 200.0, width: self.ogreJump!.size.width, height: self.ogreJump!.size.height)
        view.addSubview(ogreImageView)
        tapImageView.image = tapToPlay
        tapImageView.frame = CGRect(x: self.frame.midX + 100.0, y: self.frame.midX + 500.0, width: self.tapToPlay!.size.width, height: self.tapToPlay!.size.height)
        view.addSubview(tapImageView) */
        
        wallBackgroundNode = childNode(withName: "wallBackgroundNode")
        let wallBackground = WallBackground(node: wallBackgroundNode)
        gameObjects.append(wallBackground) // índice do background é 0 dentro do gameObjects! nao mudar a ordem!
        
        player = childNode(withName: "Player") as? Player
        player.buildPlayerTexture()
        player.animatePlayer(direction: GameConfig.right)
        
        
        backgroundScene0.zPosition = -1
        backgroundScene0.position = GameConfig.backgroundPosition
        backgroundScene0.size.width = backgroundScene0.size.width * 0.5
        backgroundScene0.size.height = backgroundScene0.size.height * 0.5
        addChild(backgroundScene0)
        backgroundScene1.zPosition = -2
        backgroundScene1.position = GameConfig.backgroundPosition
        backgroundScene1.size.width = backgroundScene1.size.width * 1.0
        backgroundScene1.size.height = backgroundScene1.size.height * 1.0
        addChild(backgroundScene1)
        backgroundScene2.zPosition = -3
        backgroundScene2.position = GameConfig.backgroundPosition
        backgroundScene2.size.width = backgroundScene2.size.width * 1
        backgroundScene2.size.height = backgroundScene2.size.height * 1
        addChild(backgroundScene2)
        backgroundScene3.zPosition = -4
        backgroundScene3.position = GameConfig.backgroundPosition
        backgroundScene3.size.width = backgroundScene3.size.width * 1
        backgroundScene3.size.height = backgroundScene3.size.height * 1
        addChild(backgroundScene3)
        backgroundScene4.zPosition = -5
        backgroundScene4.position = GameConfig.backgroundPosition
        backgroundScene4.size.width = backgroundScene4.size.width * 1
        backgroundScene4.size.height = backgroundScene4.size.height * 1
        addChild(backgroundScene4)
        backgroundScene5.zPosition = -6
        backgroundScene5.position = GameConfig.backgroundPosition
        backgroundScene5.size.width = backgroundScene5.size.width * 1
        backgroundScene5.size.height = backgroundScene5.size.height * 1
        addChild(backgroundScene5)
        
        currentDistance = SKLabelNode(fontNamed: "Reality Check DEMO")
        currentDistance.fontColor = .black
        currentDistance.horizontalAlignmentMode = .right
        currentDistance.position = GameConfig.labelScorePosition
        currentDistance.zPosition = 4
        currentDistance.numberOfLines = 3
        addChild(currentDistance)
        currentDistance.text = String(format: "Best Score: %.1f m \n\nLast Score: %.1f m", GameConfig.defaults.double(forKey: "HighScore"), GameConfig.defaults.double(forKey: "LastScore"))
        
        let flashLabelIn = SKAction.fadeIn(withDuration: 1.5)
        let flashLabelOut = SKAction.fadeOut(withDuration: 0.2)
        let sequence = SKAction.sequence([flashLabelIn, flashLabelOut])
        
        /*tapPlay = SKLabelNode(fontNamed: "Chalkduster")
        tapPlay.fontColor = .black
        tapPlay.horizontalAlignmentMode = .right
        tapPlay.text = "Tap to Play"
        tapPlay.position = CGPoint(x: 100, y: 0)
        tapPlay.zPosition = 4
        tapPlay.run(SKAction.repeatForever(sequence))
        addChild(tapPlay)*/
        
        ogreJump = SKSpriteNode(imageNamed: "OgreJump")
        ogreJump.position = CGPoint(x: 0, y: 50)
        ogreJump.size = CGSize(width: ogreJump.size.width * 1.5, height: ogreJump.size.height * 1.5)
        addChild(ogreJump)
        
        tapToPlay = SKSpriteNode(imageNamed: "tapToPlay")
        tapToPlay.position = CGPoint(x: 0, y: -150)
        tapToPlay.run(SKAction.repeatForever(sequence))
        addChild(tapToPlay)
        
        
        spawnBat = SpawningBat(node: self)
        gameObjects.append(spawnBat)
        spawnObstacle = SpawningObstacle(node: self)
        gameObjects.append(spawnObstacle)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody!
        var secondBody: SKPhysicsBody!
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if !hasDied {
            if abs(firstBody.node!.position.x).rounded(.up) >= abs(GameConfig.xRightPosition){
                //morreu
//                secondBody.node!.removeFromParent()
                gameVel = -GameConfig.gameSpeed
                GameConfig.backgroundSpeed = -GameConfig.backgroundSpeed
                player.removeAllActions()
                player.texture = SKTexture(imageNamed: "0_Ogre_Dying_009")
                finalDistance = distance
                if distance > GameConfig.defaults.double(forKey: "HighScore") {
                    GameConfig.defaults.set(distance, forKey: "HighScore")
                }
                hasDied = true
                player.deadPlayer()
            } else if secondBody.categoryBitMask == GameConfig.ObstacleCategory {
                //morreu
                gameVel = -GameConfig.gameSpeed
                GameConfig.backgroundSpeed = -GameConfig.backgroundSpeed
                player.removeAllActions()
                player.texture = SKTexture(imageNamed: "0_Ogre_Dying_009")
                finalDistance = distance
                if distance > GameConfig.defaults.double(forKey: "HighScore") {
                    GameConfig.defaults.set(distance, forKey: "HighScore")
                }
                hasDied = true
                player.deadPlayer()
            } else {
                //            contact.bodyB.node?.removeFromParent()
                secondBody.node!.removeFromParent()
            }
        }
    }
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if !tapToPlay.isHidden {
            //            tapPlay.removeAllActions()
            tapToPlay.isHidden = true
            ogreJump.isHidden = true
            hasDied = false
            gameVel = GameConfig.gameSpeed
            distance = 0
            currentDistance.position = GameConfig.runningScorePosition
        } else if !hasDied{
            player.jumpPlayer()
        }
    }
    
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
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
        let deltaTime = currentTime - lastTimeUpdate
        lastTimeUpdate = currentTime
        
        if tapToPlay.isHidden {
            for gameObject in gameObjects {
                gameObject.update(deltaTime: deltaTime, velocity: gameVel)
            }
            
            // funcao para aumentar velocidade do jogo, calibrar para ajustar a dificuldade
            if deltaTime < 0.05 {
                gameVel += deltaTime/8
                distance += gameVel/60
            }
            if hasDied && finalDistance - distance > 8 {
                tapToPlay.isHidden = false
                ogreJump.isHidden = false
                player.setUp()
                player.animatePlayer(direction: GameConfig.right)
                GameConfig.backgroundSpeed = GameConfig.backgroundSpeed * -1
                spawnBat.destroySpawn()
                spawnObstacle.destroySpawn()
                GameConfig.defaults.set(finalDistance, forKey: "LastScore")
                currentDistance.text = String(format: "Best Score: %.1f m \n\nLast Score: %.1f m", GameConfig.defaults.double(forKey: "HighScore"), GameConfig.defaults.double(forKey: "LastScore"))
                currentDistance.position = GameConfig.labelScorePosition
            } else if !hasDied {
                currentDistance.text = String(format: "%.1f m", distance)
            }
            
        } else {
            gameObjects[0].update(deltaTime: deltaTime, velocity: gameVel)
        }
    }
}
