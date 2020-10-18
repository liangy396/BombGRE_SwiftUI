//
//  ClassicalCard.swift
//  BombGRE
//
//  Created by Liang Yang on 5/29/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import Foundation

struct ExplanationCard: Identifiable {
    
    var isMatched: Bool = false
    var isSeen: Bool = false
    var content: String
    var id: Int
}

struct WordCard: Identifiable {
    
    var isSeen: Bool = false
    var content: String
    var id: Int
}
