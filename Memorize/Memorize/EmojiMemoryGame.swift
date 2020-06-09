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
    private static func createMemoryGame() -> MemoryGame<String> {
        var gameThemes:Array<Theme> = []
        gameThemes.append(Theme(name: "Hallowween", cardSet: ["👻","🎃","🕷"], color: Color.orange))
        gameThemes.append(Theme(name: "Sport", cardSet: ["🏀","🏈","🏐","🏸","🎾"], color: Color.blue))
        gameThemes.append(Theme(name: "Animals", cardSet: ["🐶","🐭","🐌","🐒","🦄"], color: Color.yellow))
        gameThemes.append(Theme(name: "Travel", cardSet: ["🏎","🚲","🚐","🚎","🚘"], color: Color.pink))
        gameThemes.append(Theme(name: "Object", cardSet: ["💿","🖥","⌛️","🛢"], color: Color.green))
        gameThemes.append(Theme(name: "Flag", cardSet: ["🏁","🇧🇴","🇧🇮"], color: Color.gray))
        let themeIndex = Int.random(in: 0 ..< gameThemes.count)
        let chosenTheme = gameThemes[themeIndex]
        if let numPair = chosenTheme.num {
            return  MemoryGame(theme:chosenTheme,numberOfPairsOfCards: numPair,cardContentFactory: {pairIndex in return chosenTheme.cardSet[pairIndex]})
        } else {
            return  MemoryGame(theme:chosenTheme,numberOfPairsOfCards: Int.random(in: 2 ..< chosenTheme.cardSet.count),cardContentFactory: {pairIndex in return chosenTheme.cardSet[pairIndex]})
        }
        
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score:Int {
        return model.score
    }
    
    var theme:Theme {
        return model.theme
    }

    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func reset() {
        self.model = EmojiMemoryGame.createMemoryGame()
    }
}

