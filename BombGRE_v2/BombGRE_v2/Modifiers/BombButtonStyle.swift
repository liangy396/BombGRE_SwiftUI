//
//  BombButtonStyle.swift
//  BombGRE_v2
//
//  Created by Liang Yang on 6/8/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

//Reference 1: https://www.appcoda.com/swiftui-button-style-animation/
//Reference 2: https://alejandromp.com/blog/playing-with-swiftui-buttons/

import SwiftUI

struct BombButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.yellow)
            .cornerRadius(100)
            .scaleEffect(0.9)
    }
}

extension View {
    func bombButton() -> some View {
        self.modifier(BombButtonStyle())
    }
}
