//
//  TrailLine.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/7/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//
// Adapted from: https://www.youtube.com/watch?v=DL2YQa9Ryp4&feature=youtu.be

import SpriteKit

class TrailLine: SKShapeNode {
    
    var shrinkTimer = Timer()
    
    init(location: CGPoint, previous: CGPoint, width: CGFloat, color: UIColor) {
        super.init()
        
        let path = CGMutablePath()
        path.move(to: location)
        path.addLine(to: previous)
        
        self.path = path
        
        lineWidth = width
        strokeColor = color
        
        shrinkTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: {
            _ in
            self.lineWidth -= 1
            if self.lineWidth == 0 {
                self.shrinkTimer.invalidate()
                self.removeFromParent()
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
