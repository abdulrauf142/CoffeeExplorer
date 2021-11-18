//
//  CoffeeExplorerApp.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI

@main
struct CoffeeExplorerApp: App {
    
    init() {
        Network.fourSquareConfig = FoursquareConfig(
            clientID: "4THX0X2VG2QU0VXWEZTUUA5HDRLD1MYDRXQZU5KAPT5CTVJF",
            clientSecret: "RZVE20W4ZRQKLO3NQSUDJFZEV1LVJGZI0U4PDW2LXZBUGZU4",
            version: "20193112"
        )
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(AppState())
        }
    }
}
