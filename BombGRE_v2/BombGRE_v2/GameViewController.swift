//
//  GameViewController.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/7/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//
//Reference: https://www.thedreamweb.eu/blog/files/swiftui-for-spritekit-games.html


import UIKit
import SpriteKit
import GameplayKit
import SwiftUI

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(fileNamed: "GameScene")
            scene!.playSoundEffect(soundFile: "Take_Your_Time.mp3", looped: true)
            scene?.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            //add the Launch UI to the screen
            let modeStore = ModeStore()
            let difficultyStore = DifficultyStore()
            let musicStore = MusicStore()
            let classicalViewGame = ClassicalGameViewModel(difficulty: "Easy", numberOfWords: 10)
            let lauchUI = LauchUIView(gameScene: scene!, viewGame: classicalViewGame).environmentObject(modeStore).environmentObject(difficultyStore).environmentObject(musicStore) // pass environemnt objects
            let uiController = UIHostingController(rootView: lauchUI)
            addChild(uiController)

            uiController.view.frame = view.frame
            uiController.view.backgroundColor = UIColor.clear
            view.addSubview(uiController.view)
        }
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
