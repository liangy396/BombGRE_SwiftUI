//
//  HelperFunctions.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/7/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//
// citation source: https://www.youtube.com/watch?v=DL2YQa9Ryp4&feature=youtu.be

import Foundation
import UIKit

func randomCGFloat(_ lowerLimit: CGFloat, _ upperLimit: CGFloat) -> CGFloat {
    return lowerLimit + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upperLimit - lowerLimit)
}
