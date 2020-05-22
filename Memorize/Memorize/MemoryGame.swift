//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jerry Lin on 22/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    
    init(numberOfPairsOfCards: Int,cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    struct Card:Identifiable {
        var id = UUID()
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
