//
//  VenueDetailResponse.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Foundation

extension Server {
    
    // MARK: - Welcome
    struct VenueDetailsResponse: Decodable {
        let meta: Meta
        let response: Response
        
        // MARK: - Response
        struct Response: Decodable {
            let venue: VenueDetail
        }
    }
    
    // MARK: - Venue
    struct VenueDetail: Decodable {
        let id: String
        let name: String?
        let location: Location?
        let description: String?
        let tips: Listed?
        let hours: Hours?
        let hierarchy: [Hierarchy]?
        let bestPhoto: Photo?
    }

    // MARK: - Photo
    struct Photo: Decodable {
        let id: String?
        let createdAt: Int?
        let prefix: String?
        let suffix: String?
        let width, height: Int?
        let visibility: String?
    }

    // MARK: - FluffyItem
    struct FluffyItem: Decodable {
        let id: String
        let name: String?
        let text: String?
        let type: String?
        let user: User?
        let createdAt: Int?
    }

    // MARK: - HereNowGroup
    struct HereNowGroup: Decodable {
        let type: String?
        let count: Int?
        let items: [FluffyItem]?
        let name: String?
    }
    
    // MARK: - Hierarchy
    struct Hierarchy: Decodable {
        let name: String?
        let lang: String?
        let id: String?
        let canonicalURL: String?

        enum CodingKeys: String, CodingKey {
            case name, lang, id
            case canonicalURL = "canonicalUrl"
        }
    }

    // MARK: - Listed
    struct Listed: Decodable {
        let count: Int?
        let groups: [HereNowGroup]?
    }
}
