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
        VStack{
            Text("\(viewModel.theme.name)")
                .font(.title)
                .padding()
            
            VStack {
                Grid(viewModel.cards){ card in
                    CardView(card: card,filledColor: self.viewModel.theme.color).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                .padding()
                .foregroundColor(Color.orange)
                
                Spacer()
                
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.blue)
                        Button(action: {
                            self.viewModel.reset()
                        }){
                            Text("New Game")
                        }
                        .foregroundColor(.black)
                    }
                    .frame(width: 100  , height: 40)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.blue)
                        
                        Text("Score:\(viewModel.score)")
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 100  , height: 40)
                }
                .frame(width: 200, height: 100, alignment: .center)
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var filledColor:Color
    
    var body: some View {
        GeometryReader(content:{ geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth:self.edgeLineWidth)
                    Text(self.card.content)
                } else {
                    if !self.card.isMatched {
                        RoundedRectangle(cornerRadius: self.cornerRadius).fill(self.filledColor)
                    }
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
