//
//  File.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import Foundation

enum File: String {
    
    case venueListResponse = "VenueListResponse"
    case failedVenueListResponse = "FailedVenueListResponse"
    case venueDetailsReponse = "VenueDetailsView"
    
    var data: Data? {
        let bundle = Bundle(for: NetworkManagerTests.self)
        guard let path = bundle.path(forResource: rawValue, ofType: "json") else {
            fatalError("\(rawValue).json not found")
        }
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Unable to convert \(rawValue).json to String")
        }
        return jsonString.data(using: .utf8)
    }
}
