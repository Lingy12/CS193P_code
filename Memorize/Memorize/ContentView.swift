//
//  ContentView.swift
//  Memorize
//
//  Created by Jerry Lin on 21/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack{
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(viewModel.cards.count == 5 ? Font.title:Font.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            if card.isMatched {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            }
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth:3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }.aspectRatio(2/3, contentMode: .fit)
                       
    }
}
