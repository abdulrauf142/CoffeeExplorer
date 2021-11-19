//
//  VenueDetailsRequest.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Foundation

struct VenueDetailsRequest: RequestBuildable {
    
    private let venueID: String
    
    var path: String { "/v2/venues/\(venueID)" }
    var parameters: Parameters {
        ["v" : Network.fourSquareConfig.version,
         "client_id": Network.fourSquareConfig.clientID,
         "client_secret": Network.fourSquareConfig.clientSecret]
    }
    
    init(venueID: String) {
        self.venueID = venueID
    }
}
