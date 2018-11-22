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
    var cards = [Card]() {
        didSet {
            
        }
        
        willSet {
            
        }
    }
    
    var indexOfOneAndAnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchindex = indexOfOneAndAnlyFaceUpCard, matchindex != index {
                // check if cards match
                if cards[matchindex].identifier == cards[index].identifier {
                    cards[matchindex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndAnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndAnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfcards: Int) {
        for _ in 1...numberOfPairsOfcards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}
