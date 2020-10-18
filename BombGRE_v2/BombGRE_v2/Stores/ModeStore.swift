//
//  ModeStore.swift
//  BombGRE
//
//  Created by Liang Yang on 5/29/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import SwiftUI

class ModeStore: ObservableObject
{
    @Published var modes: Array<String> = ["Bomb", "Classical"]
    var defaultMode: String = "Bomb"
}
