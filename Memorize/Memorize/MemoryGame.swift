//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jerry Lin on 22/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent:Equatable> {
    var cards: Array<Card>
    var score = 0
    var seen:Array<Card> = []
    var theme:Theme
    
    var indexOfTheOnlyFaceUpCard:Int? {
        get {
            cards.indices.filter{cards[$0].isFaceUp}.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(theme:Theme,numberOfPairsOfCards: Int,cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()//shuffle the card
        self.theme = theme
    }
    
    
    //adding key word "mutating" to mutate the self state
    mutating func choose(card: Card) {
        print("chose the card: \(card)")
        
        if let chosenIndex = self.cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp,!cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    self.score += 2
                } else {
                    if seen.firstIndex(matching: cards[chosenIndex]) != nil {
                        self.score -= 1
                    }
                    if seen.firstIndex(matching: cards[potentialMatchIndex]) != nil {
                        self.score -= 1
                    }
                    seen.append(cards[chosenIndex])
                    seen.append(cards[potentialMatchIndex])
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card:Identifiable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        var id = UUID()
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
