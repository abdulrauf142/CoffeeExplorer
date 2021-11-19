//
//  VenueListReponse.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

struct VenueListResponse {
    let totalResults: Int
    let venues: [Venue]
    
    init(with response: Server.VenueListResponse) {
        let serviceResponse = response.response
        totalResults = serviceResponse.totalResults ?? 0
        venues = serviceResponse.groups?.first?.items?.map { Venue(with: $0.venue) } ?? []
    }
}

struct Venue: Identifiable {
    let id: String
    let name: String
    let address: String
    let distance: String
    let category: String
    let coordinates: Coordinate
    var thumbnail: URL?
    
    // MARK: - initializer
    init(with venue: Server.Venue) {
        
        id = venue.id
        name = venue.name
        address = venue.location.address ?? "unknown"
        
        let distanceInKM = Float(venue.location.distance ?? 0) / Float(1000)
        distance = String(format:"%.1f km", distanceInKM)
        
        category = venue.categories.first?.shortName ?? ""
        coordinates = Coordinate(lat: venue.location.lat, lng: venue.location.lng)
        
        guard let photo = venue.photos?.groups.first?.items?.first else { return }
        let url = (photo.prefix ?? "") + "64x64" + (photo.suffix ?? "")
        thumbnail = URL(string: url)
    }
}

struct Coordinate {
    let lat: Double
    let lng: Double
}
