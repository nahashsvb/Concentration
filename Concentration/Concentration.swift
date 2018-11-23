//
//  Concentration.swift
//  Concentration
//
//  Created by Serhii Borysov on 11/22/18.
//  Copyright © 2018 Serhii Borysov. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndAnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards)")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndAnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
