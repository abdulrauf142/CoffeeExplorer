//
//  HomeView.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("KEY_HELLO_WORLD".localized)
            .font(.poppins(size: 18))
            .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
