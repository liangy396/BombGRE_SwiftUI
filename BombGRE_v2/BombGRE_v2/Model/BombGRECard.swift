//
//  Fruits.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/7/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

//Adapted from: https://www.youtube.com/watch?v=DL2YQa9Ryp4&feature=youtu.be

import SpriteKit

class BombGRECard: SKNode {
    
    //let keys = difficulty == "Easy" ? CommonVocab.map {$0.key} : AdvancedVocab.map {$0.key}
    //let values = difficulty == "Easy" ? CommonVocab.map {$0.value} : AdvancedVocab.map {$0.value}
    
    let cardEmojis = ["🍎","🍏","🍉","🍑","🍌","🍓"]
    let bombEmoji = "💣"
    
    
    override init() {
        super.init()
        
        var emoji = ""
        
        if randomCGFloat(0, 1) < 0.9 {
            name = "word"
            let n = Int(arc4random_uniform(UInt32(cardEmojis.count)))
            emoji = cardEmojis[n]
        } else {
            name = "bomb"
            emoji = bombEmoji
        }
        
        let label = SKLabelNode(text: emoji)
        label.fontSize = 120
        label.verticalAlignmentMode = .center
        addChild(label)
        
        physicsBody = SKPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

