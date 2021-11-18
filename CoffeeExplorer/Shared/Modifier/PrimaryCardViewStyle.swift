//
//  PrimaryCardStyle.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import SwiftUI
struct PrimaryCardViewStyle: ViewModifier {
    var radius: CGFloat
    func body(content: Content) -> some View {
        content
            .cornerRadius(radius)
            .shadow(color: Color.gray.opacity(0.8), radius: 2, x: 0, y: 1)
    }
}
