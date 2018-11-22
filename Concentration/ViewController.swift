//
//  ViewController.swift
//  Concentration
//
//  Created by Serhii Borysov on 11/21/18.
//  Copyright © 2018 Serhii Borysov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfcards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    var emojiChoices = ["👻","🎃","🌲","🌳","🌷","🌹","❄️","☃️","🍏","🍐","💩"]
    
    var emoji = [Int:String]()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel(cardNumber: cardNumber)
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(cardNumber number: Int) {
        for index in cardButtons.indices  {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                if number == index {
                    UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                }
            }
            else  {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                if number == index {
                    UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                }
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

