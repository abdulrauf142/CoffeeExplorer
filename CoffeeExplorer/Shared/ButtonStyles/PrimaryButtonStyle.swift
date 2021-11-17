//
//  PrimaryButtonStyle.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let height: CGFloat
    var color = ColorPalette.primary.color
    var cornerRadius: CGFloat = 4.0
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity, maxHeight: height)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(height/2)
    }
}
