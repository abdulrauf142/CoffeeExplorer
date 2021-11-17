//
//  RootView.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI
import Combine

struct RootView: View {
    
    let viewModel = RootViewModel()
    
    var body: some View {
        rootView
            .onAppear {
                viewModel.hasSeenAppOnBoarding = true
            }
    }
    
    @ViewBuilder
    var rootView: some View {
        switch viewModel.hasSeenAppOnBoarding {
        case true:
            HomeView()
        default:
            OnBoardingView()
        }
    }
}

struct RootView_Preview: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

