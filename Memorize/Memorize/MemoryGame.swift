//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jerry Lin on 22/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent:Equatable> {
    
    init(numberOfPairsOfCards: Int,cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    var cards: Array<Card>
   
    
    //adding key word "mutating" to mutate the self state
    mutating func choose(card: Card) {
        let chosenIndex = self.index(of: card)
        
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
        
        print("chose the card: \(card)")

    }
    
    func index(of card:Card) -> Int {
        for index in 0 ..< self.cards.count{
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0//TODO: rogus
    }
    
    
    struct Card:Identifiable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        var id = UUID()
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
