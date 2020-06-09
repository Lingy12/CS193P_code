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
    
    @ViewBuilder
    var body: some View {
        GeometryReader(content:{ geometry in
            if self.card.isFaceUp || !self.card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110 - 90))
                        .padding().opacity(0.4)
                    //degree 0 is right
                    Text(self.card.content)
                }
                
            }
            
        })
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            game.choose(card: game.cards[0])
            return EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
    
    
}
