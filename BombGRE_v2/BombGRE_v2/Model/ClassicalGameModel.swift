//
//  GREGameModel.swift
//  BombGRE
//
//  Created by Liang Yang on 5/28/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import Foundation

struct ClassicalGameModel {
    
    private(set) var cards: Array<ExplanationCard>
    private(set) var tableCards = Array<ExplanationCard>()
    private(set) var tableWordCard = WordCard(content: "", id: 0) //initializater
    private(set) var wordCards: Array<WordCard>
    
    private var difficulty: String
    var score: Int
    var ended: Bool = false
    private var dealCount: Int = 0
    private var numberOfCards: Int = 10
    
    init(numberOfCards: Int, difficulty: String) {
        self.numberOfCards = numberOfCards
        self.difficulty = difficulty
        score = 0
        cards = Array<ExplanationCard>()
        wordCards = Array<WordCard>()
        
        let keys = difficulty == "Easy" ? CommonVocab.map {$0.key} : AdvancedVocab.map {$0.key}
        let values = difficulty == "Easy" ? CommonVocab.map {$0.value} : AdvancedVocab.map {$0.value}
        var Index = 0
        for ind in 0 ..< numberOfCards {
            //add word cards
            let wordcontent = keys[ind]
            wordCards.append(WordCard(content: wordcontent, id: Index))
            
            //add explanation cards
            var expcontent = values[ind] //get the correct explanation first
            cards.append(ExplanationCard(content: expcontent, id: Index))

            //get random explanations
            var randInd = Int.random(in: 0..<values.count)
            if randInd == ind {
                randInd = Int.random(in: 0..<values.count)
            }
            expcontent = values[randInd]
            cards.append(ExplanationCard(content: expcontent, id: (Index+1)*100))

            randInd = Int.random(in: 0..<values.count)
            if randInd == ind {
                randInd = Int.random(in: 0..<values.count)
            }
            expcontent = values[randInd]
            cards.append(ExplanationCard(content: expcontent, id: (Index+1)*101))
            
            Index += 1
        }
        //cards.shuffle() // shuffle the deck
        initTable()
    }
    
    mutating func choose(card: ExplanationCard){
        if dealCount >= numberOfCards-1 {
            ended = true
            return
        } else {
            let chosenIndex: Int = tableCards.firstIndex(matching: card)!
            if !match(on: tableCards[chosenIndex], tableWordCard: tableWordCard){
                cards[chosenIndex].isMatched = false
                score = score - 1 //deduct 1 point if the card was not matched
            } else {
                cards[chosenIndex].isMatched = true
                score = score + 1
            }
            dealCards() //once choose a card, show more cards
            dealCount = dealCount + 1
        }
        
    }
    
    private func match(on selectedCard: ExplanationCard, tableWordCard: WordCard) -> Bool {
        let vocab = difficulty == "Easy" ? CommonVocab : AdvancedVocab
        return vocab[tableWordCard.content] == selectedCard.content
    }

    //add 3 cards to the table initially
    private mutating func initTable() {
        let newCards = draw()
        for card in newCards {
            tableCards.append(card)
        }

        var wordCard = wordCards.removeFirst()
        wordCard.isSeen = true
        tableWordCard = wordCard
    }
    
    //add 3 cards to the table
    private mutating func dealCards() {
        for card in tableCards {
            let Index: Int = tableCards.firstIndex(matching: card)!
            tableCards[Index].isSeen = true
        }
        tableCards.removeAll()
        let newCards = draw()
        for card in newCards {
            tableCards.append(card)
        }
        
        var wordCard = wordCards.removeFirst()
        wordCard.isSeen = true
        tableWordCard = wordCard
    }

    //function to draw 3 (default) cards
    private mutating func draw()->Array<ExplanationCard> {
        var newCards: Array<ExplanationCard> = [] //a new array of cards
        if cards.count > 0 { // if we still have cards in the deck
            for _ in 0 ..< 3 {
                let card = cards.removeFirst()
                newCards.append(card) // remove the first card from the deck
            }
        }
        return newCards //return new cards no matter if it's empty or not
    }

}



