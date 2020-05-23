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
    var numOfFaceUp = 0
    var score = 0
    
    mutating func choose(card: Card) {
        print("chose the card: \(card)")
        let chosenIndex = cards.firstIndex(of: card)
        
        cards[chosenIndex!].isFaceUp = true
        numOfFaceUp += 1
        
        if numOfFaceUp == 2 {
            match(index: chosenIndex!)
        }
    }
    
    mutating func match(index: Int) {
        for i in cards.indices {
            if cards[i].content == cards[index].content && cards[i].isFaceUp {
                cards[i].isMatched = true
                cards[index].isMatched = true
                score += 1
            } else if cards[i].isFaceUp {
                cards[i].isFaceUp = false
                cards[index].isFaceUp = false
            }
        }
        numOfFaceUp = 0
    }
    
    struct Card:Identifiable,Equatable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        var id = UUID()
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
