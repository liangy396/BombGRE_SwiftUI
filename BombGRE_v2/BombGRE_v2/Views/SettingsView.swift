//
//  SettingsView.swift
//  BombGRE
//
//  Created by Liang Yang on 5/29/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

//Reference: https://www.simpleswiftguide.com/how-to-create-and-use-picker-with-form-in-swiftui/

import SwiftUI

struct SettingsView: View {
    
    //@EnvironmentObject var gameScene: GameScene
    //@EnvironmentObject var classicalViewGame: ClassicalGameViewModel
    @EnvironmentObject var modeStore: ModeStore
    @EnvironmentObject var difficultyStore: DifficultyStore
    @EnvironmentObject var musicStore: MusicStore

    @Binding var modeIndex: Int
    @Binding var vocabLevelIndex: Int
    @Binding var musicIndex: Int
    @Binding var numberOfOnScreenCards: Int
    @Binding var numberOfWords: Int
    @Binding var soundEffect: Bool
    
    @Binding var isShowing: Bool
    
    var body: some View {
        Group {
            ZStack {
                Text("Settings").padding().font(Font.custom("Chalkduster", size: 30))
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                    }, label: {Text("Save")}).padding().font(Font.custom("Chalkduster", size: 15))
                }
            }
            NavigationView {
                Form {
                    Section {
                        Picker(selection: $modeIndex, label: Text("Game Mode").font(Font.custom("Chalkduster", size: 15))) {
                            ForEach(0 ..< self.modeStore.modes.count) {
                                Text(self.modeStore.modes[$0])
                                .font(Font.custom("Chalkduster", size: 15))
                            }
                        }
                    }
                    Section {
                        Picker(selection: $vocabLevelIndex, label: Text("Vocabulary Levels").font(Font.custom("Chalkduster", size: 15))) {
                            ForEach(0 ..< self.difficultyStore.difficulties.count) {
                                Text(self.difficultyStore.difficulties[$0])
                                .font(Font.custom("Chalkduster", size: 15))
                            }
                        }
                    }
                    Section {
                        Picker(selection: $musicIndex, label: Text("Music").font(Font.custom("Chalkduster", size: 15))) {
                            ForEach(0 ..< self.musicStore.musicLibrary.count) {
                                Text(self.musicStore.musicLibrary[$0])
                                .font(Font.custom("Chalkduster", size: 15))
                            }
                        }
                    }
                }
            }
            
            Form {
                Section(header: Text("Number of Words").font(Font.custom("Chalkduster", size: 20))) {
                    Stepper(onIncrement: {
                        self.numberOfWords += 1
                        //self.classicalViewGame.numberOfWords = self.numberOfWords
                        //self.gameScene.numberOfWords = self.numberOfWords
                    }, onDecrement: {
                        self.numberOfWords -= 1
                        //self.classicalViewGame.numberOfWords = self.numberOfWords
                        //self.gameScene.numberOfWords = self.numberOfWords
                    }, label: { Text(String(self.numberOfWords)).font(Font.custom("Chalkduster", size: 20)) })
                }
                Section(header: Text("Number of On Screen Cards (Bomb Mode Only)").font(Font.custom("Chalkduster", size: 20))) {
                    Stepper(onIncrement: {
                        self.numberOfOnScreenCards += 1
                        //self.gameScene.numberOfCards = self.numberOfOnScreenCards
                    }, onDecrement: {
                        self.numberOfOnScreenCards -= 1
                        //self.gameScene.numberOfCards = self.numberOfOnScreenCards
                    }, label: { Text(String(self.numberOfOnScreenCards)).font(Font.custom("Chalkduster", size: 20)) })
                }
                Section {
                    Toggle(isOn: $soundEffect) {
                        Text("Sound Effect (Bomb Mode Only)").font(Font.custom("Chalkduster", size: 20))
                    }.padding()
                    
                }
            }
            
        }
    }
}
