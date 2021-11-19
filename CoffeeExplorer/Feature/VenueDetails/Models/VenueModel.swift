//
//  VenueModel.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Foundation

struct VenueModel {
    
    let name: String
    private(set) var photoURL: URL?
    private(set) var address: String?
    private(set) var description: String?
    private(set) var openStatus: String?
    private(set) var recommendations: [Recommendation] = []
    
    init(venue: Server.VenueDetail) {
        
        name = venue.name ?? ""
        
        address = venue.location?.address
        if let locationAddress =  venue.location?.address {
            address = locationAddress + " - " + (venue.hierarchy?.first?.name ?? "")
        }

        if let photo = venue.bestPhoto,
            let prefix = photo.prefix,
            let suffix = photo.suffix,
            let width = photo.width,
            let height = photo.height {

            photoURL = URL(string: "\(prefix)\(width)x\(height)\(suffix)")
        }


        description = venue.description
        openStatus = venue.hours?.status
        recommendations = venue.tips?.groups?.first?.items?.map { item in
            Recommendation(fluffyItem: item)
        } ?? []
    }
    
    
    struct Recommendation: Identifiable {
        let id: String
        let comment: String
        let createAt: Int
        let user: User
        
        var date: String {
            let date = Date(timeIntervalSince1970: TimeInterval(createAt))
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd YYYY"
            return formatter.string(from: date)
        }
        
        init(fluffyItem: Server.FluffyItem) {
            id = fluffyItem.id
            comment = fluffyItem.text ?? ""
            createAt = fluffyItem.createdAt ?? 0
            user = User(firstName: fluffyItem.user?.firstName ?? "",
                        lastName: fluffyItem.user?.lastName ?? "")
        }
    }
    
    struct User {
        let firstName: String
        let lastName: String
        
        
        var fullName: String {
            firstName + " " + lastName
        }
    }
}
