//
//  String+Localization.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI

extension String {
    var localized: LocalizedStringKey {
        LocalizedStringKey(self)
    }
}
