//
//  Concentration.swift
//  Concentration
//
//  Created by Serhii Borysov on 11/22/18.
//  Copyright © 2018 Serhii Borysov. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndAnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards)")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndAnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndAnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfcards: Int) {
        assert(numberOfPairsOfcards > 0, "Concentration.init(numberOfPairsOfcards: \(numberOfPairsOfcards): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfcards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}
