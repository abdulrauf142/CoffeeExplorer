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
    let radius = 10000
    let section = "coffee"
    let venuePhotosCount = 1
    
    let offset: Int
    let coordinate: Coordinate
}
