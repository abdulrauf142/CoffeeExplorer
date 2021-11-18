//
//  VenueListRequest.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

struct VenueListRequest: RequestBuildable {
    
    // MARK: - Properties
    private let query: VenueListQuery
    
    // MARK: - Computer Propertiees
    var path: String { "/v2/venues/explore" }
    
    var parameters: Parameters {
        ["radius": query.radius,
        "section": query.section,
         "offset" : "\(query.offset)",
         "ll": "\(query.coordinate.lat),\(query.coordinate.lng)",
         "v" : Network.fourSquareConfig.version,
         "limit" : query.limit,
         "venuePhotos": query.venuePhotosCount,
         "client_id": Network.fourSquareConfig.clientID,
         "client_secret": Network.fourSquareConfig.clientSecret]
    }
    
    // MARK: - Initializer
    init(query: VenueListQuery) {
        self.query = query
    }
}
