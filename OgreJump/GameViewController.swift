//
//  GameViewController.swift
//  OgreJump
//
//  Created by M Cavasin on 03/03/20.
//  Copyright © 2020 M Cavasin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameScene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                gameScene = (scene as! GameScene)
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
//            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
//        gameScene?.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9019607843, blue: 0.8470588235, alpha: 1)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
