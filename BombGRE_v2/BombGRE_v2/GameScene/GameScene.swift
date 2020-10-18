//
//  GameScene.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/7/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//
//Reference 1: https://www.youtube.com/watch?v=DL2YQa9Ryp4&feature=youtu.be
//Reference 2: https://www.hackingwithswift.com/read/36/6/background-music-with-skaudionode-an-intro-plus-game-over


import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene, ObservableObject {

    var score: Int = 0
    var best: Int = 0
    var misses: Int = 0
    var missesMax: Int = 3
    
    @Published var soundEffect: Bool = false
    @Published var numberOfWords: Int = 10
    @Published var numberOfCards: Int = 5
    @Published var musicFileName: String = "Take_Your_Time.mp3"
    
    var gamePhase = GamePhase.Ready
    
    var promptLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var bestLabel = SKLabelNode()
    var explanationLable = SKLabelNode()
    
    var cardThrowTimer = Timer()
    
    var missedMarks = MissedMarks()
    
    var explodeOverlay = SKShapeNode()
    
    var backgroundMusic = SKAudioNode()
    
    override func didMove(to view: SKView) {
        
        
        scoreLabel = childNode(withName: "score label") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        bestLabel = childNode(withName: "best label") as! SKLabelNode
        bestLabel.text = "Best: \(best)"
        
        promptLabel = childNode(withName: "prompt label") as! SKLabelNode
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        missedMarks = MissedMarks(num: missesMax)
        missedMarks.position = CGPoint(x: size.width - 150, y: size.height - 80)
        addChild(missedMarks)
        
        explodeOverlay = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        explodeOverlay.fillColor = .white
        addChild(explodeOverlay)
        explodeOverlay.alpha = 0
        
        if UserDefaults.standard.object(forKey: "best") != nil {
            best = UserDefaults.standard.object(forKey: "best") as! Int
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let previous = t.previousLocation(in: self)
            
            for node in nodes(at: location) {
                if node.name == "word" {
                    score += 1
                    scoreLabel.text = "\(score)"
                    node.removeFromParent()
                    particleEffect(position: node.position)
                    //exploding, sound effect
                    if soundEffect {
                        playSoundEffect(soundFile: "Chopping.mp3", looped: false)
                    }
                    
                }
                
                if node.name == "bomb" {
                    if soundEffect {
                        playSoundEffect(soundFile: "Explosion.mp3", looped: false)
                    }
                    
                    bombExplode()
                    gameOver()
                    particleEffect(position: node.position)
                }
            }
            
            let line = TrailLine(location: location, previous: previous, width: 8, color: UIColor.blue)
            addChild(line)

        }
    }
    
    override func didSimulatePhysics() {
        
        for fruit in children {
            if fruit.position.y < -100 {
                fruit.removeFromParent()
                if fruit.name == "word" {
                    missCard()
                }
            }
        }
    }
    
    func startGame() {
        if gamePhase == .Ready {
            gamePhase = .InPlay
            
        }
        
        playBackgroundMusic()
        
        score = 0
        scoreLabel.text = "\(score)"
        
        bestLabel.text = "Best: \(best)"
        
        misses = 0
        missedMarks.reset()
        
        promptLabel.isHidden = true
        bestLabel.isHidden = false
        scoreLabel.isHidden = false

        cardThrowTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { _ in
            self.createCards()
        })
        
    }
    
    func createCards() {
        
        for _ in 0..<numberOfCards {
            
            let card = BombGRECard()
            card.position.x = randomCGFloat(0, size.width)
            card.position.y = -100
            addChild(card)
            
            if card.position.x < size.width/2 {
                card.physicsBody?.velocity.dx = randomCGFloat(0, 200)
            }
            
            if card.position.x >= size.width/2 {
                card.physicsBody?.velocity.dx = randomCGFloat(0, -200)
            }
            
            card.physicsBody?.velocity.dy = randomCGFloat(800, 1000)
            card.physicsBody?.angularVelocity = randomCGFloat(-5, 5)
        }

    }
    
    func missCard() {
        misses += 1
        
        missedMarks.update(num: misses)
        
        if misses == missesMax {
            gameOver()
        }
    }
    
    func bombExplode() {
        
        for case let card as BombGRECard in children {
            card.removeFromParent()
            //explode
            particleEffect(position: card.position)
        }
        
        explodeOverlay.run(SKAction.sequence([
            SKAction.fadeAlpha(to: 1, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 1, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.fadeAlpha(to: 0, duration: 0)
        ]))
    }
    
    func gameOver() {
        if score > best {
            best = score
            
            UserDefaults.standard.set(best, forKey: "best")
            UserDefaults.standard.synchronize()
        }
        
        promptLabel.isHidden = false
        promptLabel.text = "Game Over"
        promptLabel.setScale(0)
        promptLabel.run(SKAction.scale(to: 1, duration: 0.3))
        
        gamePhase = .GameOver
        
        cardThrowTimer.invalidate()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {_ in
            self.gamePhase = .Ready
        })
    }
    
    func particleEffect(position: CGPoint) {
        let emitter = SKEmitterNode(fileNamed: "Explode.sks")
        emitter?.position = position
        addChild(emitter!)
    }
    
    func playSoundEffect(soundFile: String, looped: Bool) {
        let audioNode = SKAudioNode(fileNamed: soundFile)
        audioNode.autoplayLooped = looped
        addChild(audioNode)
        audioNode.run(SKAction.play())
        audioNode.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.removeFromParent()
        ]))
    }
    
    func playBackgroundMusic() {
        self.backgroundMusic.removeFromParent()
        self.backgroundMusic = SKAudioNode(fileNamed: musicFileName)
        self.backgroundMusic.autoplayLooped = true
        addChild(self.backgroundMusic)
    }

}
