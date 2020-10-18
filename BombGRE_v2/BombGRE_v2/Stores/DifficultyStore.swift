//
//  DifficultyStore.swift
//  BombGRE
//
//  Created by Liang Yang on 5/29/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import SwiftUI

class DifficultyStore: ObservableObject
{
    @Published var difficulties: Array<String> = ["Easy", "Hard"]
    var defaultDifficulty: String = "Easy"
}
