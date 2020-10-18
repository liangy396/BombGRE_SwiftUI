//
//  LauchUIView.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/7/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import SwiftUI
import SpriteKit

struct LauchUIView: View {
    @ObservedObject var gameScene: GameScene
    @ObservedObject var viewGame: ClassicalGameViewModel
    
    @EnvironmentObject var modeStore: ModeStore
    @EnvironmentObject var difficultyStore: DifficultyStore
    @EnvironmentObject var musicStore: MusicStore
    
    @State private var modeIndex: Int = 0
    @State private var vocabLevelIndex: Int = 0
    @State private var musicIndex: Int = 0
    
    @State private var numberOfCards: Int = 5
    @State private var numberOfWords: Int = 10
    @State private var showSettings = false
    @State private var showClassicalView = false
    @State private var soundEffect = true
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button (action: {
                    if self.modeStore.modes[self.modeIndex] == "Bomb" { // bomb mode
                        self.gameScene.numberOfCards = self.numberOfCards
                        self.gameScene.numberOfWords = self.numberOfWords
                        self.gameScene.soundEffect = self.soundEffect
                        self.gameScene.musicFileName = self.musicStore.musicLibrary[self.musicIndex]
                        self.gameScene.startGame()
                    }
                    else { // classical mode
                        self.showClassicalView = true
                        self.gameScene.musicFileName = self.musicStore.musicLibrary[self.musicIndex]
                        self.gameScene.playBackgroundMusic()
                        self.gameScene.bestLabel.isHidden = true
                        self.gameScene.scoreLabel.isHidden = true
                        self.viewGame.numberOfWords = self.numberOfWords
                        self.viewGame.difficulty = self.difficultyStore.difficulties[self.vocabLevelIndex]
                        self.viewGame.restart()
                        
                    }}) {
                        Text(self.modeStore.modes[self.modeIndex] == "Bomb" ? "Let's Bomb!" : "Learn Some Words!").font(.title)
                    }
                    .sheet(isPresented: $showClassicalView) {
                        ClassicalModeView(difficulty: self.$difficultyStore.difficulties[self.vocabLevelIndex], isShowing: self.$showClassicalView, viewGame: self.viewGame)
                        }
            
                Button (action: {
                        self.showSettings = true
                    }) { Text("⚙️").font(.largeTitle)
                        .sheet(isPresented: $showSettings) {
                            SettingsView(modeIndex: self.$modeIndex, vocabLevelIndex: self.$vocabLevelIndex, musicIndex: self.$musicIndex, numberOfOnScreenCards: self.$numberOfCards, numberOfWords: self.$numberOfWords, soundEffect: self.$soundEffect, isShowing: self.$showSettings)
                                .environmentObject(self.modeStore)
                                .environmentObject(self.difficultyStore)
                                .environmentObject(self.musicStore)
                        }
                    }
            }.transition(.slide)
        }
    }
}
