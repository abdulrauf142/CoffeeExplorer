//
//  AppState.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Combine

class AppState: ObservableObject {
    
    // MARK: - Properties
    @Published var hasSeenAppOnBoarding = false
    @UserDefault(key: "has.seen.app.OnBoarding", defaultValue: false)
    private var onBoardingFlagState: Bool
    
    // MARK: - Initializer
    init() {
        hasSeenAppOnBoarding = onBoardingFlagState
    }
}
