//
//  RootView.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI
import Combine

struct RootView: View {
    // MARK: - Properties
    @EnvironmentObject var appState: AppState
    private let viewModel: RootViewModel
    
    init(viewModel: RootViewModel = RootViewModel()) {
        self.viewModel = viewModel
    }
    // MARK: - Views
    var body: some View {
        rootView
            .onReceive(appState.$hasSeenAppOnBoarding) { result in
                viewModel.hasSeenAppOnBoarding = result
            }
    }
    
    @ViewBuilder
    var rootView: some View {
        switch appState.hasSeenAppOnBoarding {
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

