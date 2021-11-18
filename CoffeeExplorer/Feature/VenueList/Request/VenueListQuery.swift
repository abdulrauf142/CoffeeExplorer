//
//  VenueListQuery.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation
import CoreLocation

struct VenueListQuery {
    let limit = 20
    let radius = 1000
    let offset = 1
    let section = "coffee"
    let venuePhotosCount = 1
    let corrrdinates: CLLocationCoordinate2D
}
