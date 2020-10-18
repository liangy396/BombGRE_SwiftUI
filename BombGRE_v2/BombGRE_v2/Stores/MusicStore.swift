//
//  MusicStore.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/8/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import SwiftUI

class MusicStore: ObservableObject
{
    @Published var musicLibrary: Array<String> = ["Forgiven_Fate.mp3", "Sweet_Release.mp3", "Take_Your_Time.mp3", "The_Blue_Pearl.mp3", "The_Sleeping_Prophet.mp3"]
    var defaultMusic: String = "Take_Your_Time.mp3"
}
