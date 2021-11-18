//
//  HomeView.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @StateObject var locationManager = LocationManager()
    
    // MARK: - Views
    var body: some View {
        rootView
            .onAppear {
                locationManager.requestForAuthorization()
            }
    }
    
    @ViewBuilder
    var rootView: some View {
        switch locationManager.status {
        case .authorizedAlways, .authorizedWhenInUse:
            if let coordinate = locationManager.coordinate {
                VenueListView(coordinate: Coordinate(lat: coordinate.latitude, lng: coordinate.longitude))
            }
        default:
            LocationPermissionPlaceholder()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
