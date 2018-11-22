//
//  Card.swift
//  Concentration
//
//  Created by Serhii Borysov on 11/22/18.
//  Copyright © 2018 Serhii Borysov. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
}
