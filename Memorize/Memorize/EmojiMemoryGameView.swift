//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jerry Lin on 21/5/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    //viewModel have observable object
    
    var body: some View {
        
        Grid(viewModel.cards){ card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
        
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content:{ geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth:self.edgeLineWidth)
                    Text(self.card.content)
                } else {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                }
            }
            .font(.system(size: min(geometry.size.width,geometry.size.height)*self.fontScaleFactor))
            .aspectRatio(2/3, contentMode: .fit)
        })
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
    
    //MARK: -Drawing Constants
    let cornerRadius:CGFloat = 10.0
    let edgeLineWidth:CGFloat = 3
    let fontScaleFactor:CGFloat = 0.75
}
