//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jerry Lin on 22/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI
import Combine


class EmojiMemoryGame:ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    //property wrapper,every time the model change, it will publish the message
    
    //make only this class can modify the model
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷","🤪","🤨"]
        return  MemoryGame(numberOfPairsOfCards: Int.random(in: 2 ..< emojis.count),cardContentFactory: {pairIndex in return emojis[pairIndex]})
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    
}

