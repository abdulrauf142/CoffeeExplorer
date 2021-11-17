//
//  RootViewModel.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import Foundation

final class RootViewModel {
    @UserDefault(key: "has.seen.app.OnBoarding", defaultValue: false)
    var hasSeenAppOnBoarding: Bool
}
