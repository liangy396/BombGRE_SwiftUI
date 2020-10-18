//
//  ClassicalModeView.swift
//  BombGRE
//
//  Created by Liang Yang on 5/28/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import SwiftUI

struct ClassicalModeView: View {
    
    @Binding var difficulty: String
    @Binding var isShowing: Bool
    @ObservedObject public var viewGame: ClassicalGameViewModel
    
    var body: some View {
        
        //stack the button for "New Game" and cards
        VStack{
            HStack {
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewGame.restart()
                    }
                }) {
                    Text("Restart")
                        .font(Font.custom("Chalkduster", size: 20))
                        .padding()
                }
                .bombButton()
                
                Spacer()
                
                Button(action: {
                    self.isShowing = false
                    
                }) {
                    Text("Quit Mode")
                        .font(Font.custom("Chalkduster", size: 20))
                        .padding()
                }
                .bombButton()
            }
            
            Spacer()
            ZStack {
                if !self.viewGame.ended {
                    VStack{
                       ForEach(viewGame.cards) { card in
                           Text(card.content)
                               .border(Color.green)
                               .padding()
                               .onTapGesture {
                                   withAnimation(.linear(duration: 0.75))
                                   {
                                       self.viewGame.choose(card: card)
                                   }
                               }
                       }
                    }
                } else {
                    Text("Game ended. You nailed \(viewGame.cards.count) words").font(Font.custom("Chalkduster", size: 30))
                }
                
            }
            
            Spacer()
            Text("Word: " + self.viewGame.wordcard.content)
                .foregroundColor(Color.black)
                .font(Font.custom("Chalkduster", size: 20))
            Divider()
            Text("Score: " + String(self.viewGame.score) )
                .foregroundColor(Color.black)
                .font(Font.custom("Chalkduster", size: 20))
            .animation(.spring())

        }
    }
}
