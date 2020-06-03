//
//  Cardify.swift
//  Assignment2
//
//  Created by Jerry Lin on 3/6/20.
//  Copyright © 2020 Jerry Lin. All rights reserved.
//

import SwiftUI
struct Cardify:ViewModifier {
    
    var isFaceUp:Bool
    var filledColor:Color
    
    func body(content: Content) -> some View {
        ZStack {
            if self.isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth:self.edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(self.filledColor)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    //MARK: -Drawing Constants
    private let cornerRadius:CGFloat = 10.0
    private let edgeLineWidth:CGFloat = 3
    private let fontScaleFactor:CGFloat = 0.75
}

extension View {
    func cardify(isFaceUp:Bool,filledColor:Color) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp, filledColor: filledColor))
    }
}
