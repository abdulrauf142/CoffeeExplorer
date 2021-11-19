//
//  LoadingView.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//


import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isLoading: Bool
    var content: () -> Content
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                content()
                    .disabled(isLoading)
                    .blur(radius: isLoading ? 2 : 0)
                
                ProgressView()
                    .opacity(isLoading ? 1 : 0)
            }
        }
    }
}
