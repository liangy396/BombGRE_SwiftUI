//
//  GREClassicalMode.swift
//  BombGRE
//
//  Created by Liang Yang on 5/28/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import SwiftUI

class ClassicalGameViewModel: ObservableObject{
    
    @Published private var game: ClassicalGameModel
    @Published var difficulty: String //the difficulty of this particular game
    @Published var numberOfWords: Int

    //initializer for the game with a difficulty level
    init(difficulty: String, numberOfWords: Int) {
        self.difficulty = difficulty
        self.numberOfWords = numberOfWords
        game = ClassicalGameModel(numberOfCards: numberOfWords, difficulty: difficulty)
    }

    //  MARK: - Access to the Model
    var cards: Array<ExplanationCard> {
        game.tableCards
    }

    var score: Int {
        game.score
    }
    
    var wordcard: WordCard {
        game.tableWordCard
    }
    
    var ended: Bool {
        game.ended
    }

    // MARK: - INTENT(s)

    func choose(card: ExplanationCard) {
        game.choose(card: card)
    }

    //function for creating a new game
    func restart() {
        game = ClassicalGameModel(numberOfCards: self.numberOfWords, difficulty: self.difficulty)
    }

}

