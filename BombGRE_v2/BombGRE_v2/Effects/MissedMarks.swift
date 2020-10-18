//
//  MissedMarks.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/7/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//
// Adapted from: https://www.youtube.com/watch?v=DL2YQa9Ryp4&feature=youtu.be

import SpriteKit
import SwiftUI

class MissedMarks: SKNode {
    
    var missedArray = [SKSpriteNode]()
    var numMissMarks = Int()
    
    let blackXPic = SKTexture(imageNamed: "x black")
    let redXPic = SKTexture(imageNamed: "x red")
    
    init(num: Int = 0) {
        super.init()
        
        numMissMarks = num
        
        for i in 0..<numMissMarks {
            let mark = SKSpriteNode(texture: blackXPic)
            mark.size = CGSize(width: 60, height: 60)
            mark.position.x = -CGFloat(i) * 70
            addChild(mark)
            missedArray.append(mark)
        }
    }
    
    func update(num: Int) {
        
        if num <= numMissMarks {
            missedArray[missedArray.count - num].texture = redXPic
        }
        
    }
    
    func reset() {
        for mark in missedArray {
            mark.texture = blackXPic
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
