//
//  VenueListResponse.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

enum Server { }

extension Server {
    
    struct VenueListResponse: Decodable {
        let meta: Meta
        let response: Response
    }
    
    // MARK: - Meta
    struct Meta: Decodable {
        let code: Int
        let errorType: String?
        let errorDetail: String?
        let requestID: String
        
        enum CodingKeys: String, CodingKey {
            case code, errorType, errorDetail
            case requestID = "requestId"
        }
    }
    
    // MARK: - Response
    struct Response: Decodable {
        let warning: Warning?
        let headerLocation: String?
        let headerFullLocation: String?
        let headerLocationGranularity: String?
        let query: String?
        let totalResults: Int?
        let suggestedBounds: SuggestedBounds?
        let groups: [ResponseGroup]?
    }
    
    // MARK: - ResponseGroup
    struct ResponseGroup: Decodable {
        let type: String?
        let name: String?
        let items: [PurpleItem]?
    }
    
    // MARK: - PurpleItem
    struct PurpleItem: Decodable {
        let reasons: Reasons?
        let venue: Venue
        let tips: [Tip]?
        let referralID: String?
        
        enum CodingKeys: String, CodingKey {
            case reasons, venue, tips
            case referralID = "referralId"
        }
    }
    
    // MARK: - Reasons
    struct Reasons: Decodable {
        let count: Int?
        let items: [ReasonsItem]?
    }
    
    // MARK: - ReasonsItem
    struct ReasonsItem: Decodable {
        let summary: String?
        let type: String?
        let reasonName: String?
    }
    
    // MARK: - Tip
    struct Tip: Decodable {
        let id: String?
        let createdAt: Int?
        let text, type: String?
        let canonicalURL: String?
        let likes: HereNow?
        let logView: Bool?
        let agreeCount: Int?
        let disagreeCount: Int?
        let todo: Todo?
        let user: User?
        
        enum CodingKeys: String, CodingKey {
            case id, createdAt, text, type
            case canonicalURL = "canonicalUrl"
            case likes, logView, agreeCount, disagreeCount, todo, user
        }
    }
    
    // MARK: - HereNow
    struct HereNow: Decodable {
        let count: Int?
        let summary: String?
    }
    
    // MARK: - Todo
    struct Todo: Decodable {
        let count: Int?
    }
    
    // MARK: - User
    struct User: Decodable {
        let firstName: String?
        let lastName: String?
        let city: String?
        let state: String?
        let countryCode: String?
    }
    
    // MARK: - Venue
    struct Venue: Decodable {
        let id: String
        let name: String
        let contact: Contact?
        let location: Location
        let categories: [Category]
        let verified: Bool?
        let stats: Stats?
        let url: String?
        let price: Price?
        let rating: Double?
        let ratingColor: String?
        let ratingSignals: Int?
        let allowMenuURLEdit: Bool?
        let beenHere: BeenHere?
        let hours: Hours?
        let photos: Photos?
        let hereNow: HereNow?
        let popularityByGeo: Double?
        let featuredPhotos: FeaturedPhotos?
        let menu: Menu?
        
        enum CodingKeys: String, CodingKey {
            case id, name, contact, location, categories, verified, stats, url, price, rating, ratingColor, ratingSignals
            case allowMenuURLEdit = "allowMenuUrlEdit"
            case beenHere, hours, photos, hereNow, popularityByGeo, featuredPhotos, menu
        }
    }
    
    // MARK: - BeenHere
    struct BeenHere: Decodable {
        let count: Int?
        let marked: Bool?
        let lastCheckinExpiredAt: Int?
    }
    
    // MARK: - Category
    struct Category: Decodable {
        let id: String?
        let name: String?
        let pluralName: String?
        let shortName: String?
        let icon: Icon?
        let primary: Bool?
    }
    
    // MARK: - Icon
    struct Icon: Decodable {
        let prefix: String
        let suffix: String
    }
    
    // MARK: - Contact
    struct Contact: Decodable {
        let phone: String?
        let formattedPhone: String?
        let facebook: String?
        let facebookUsername: String?
        let facebookName: String?
    }
    
    // MARK: - FeaturedPhotos
    struct FeaturedPhotos: Decodable {
        let count: Int?
        let items: [FeaturedPhotosItem]?
    }
    
    // MARK: - FeaturedPhotosItem
    struct FeaturedPhotosItem: Decodable {
        let id: String?
        let createdAt: Int?
        let prefix: String?
        let suffix: String?
        let width: Int?
        let height: Int?
        let visibility: String?
        
        enum CodingKeys: String, CodingKey {
            case id, createdAt
            case prefix = "prefix"
            case suffix, width, height, visibility
        }
    }
    
    // MARK: - Hours
    struct Hours: Decodable {
        let status: String?
        let isOpen: Bool?
        let isLocalHoliday: Bool
    }
    
    // MARK: - Location
    struct Location: Decodable {
        let address: String
        let lat: Double
        let lng: Double
        let labeledLatLngs: [LabeledLatLng]?
        let distance: Int?
        let cc: String?
        let city: String?
        let state: String?
        let country: String?
        let formattedAddress: [String]?
        let crossStreet: String?
    }
    
    // MARK: - LabeledLatLng
    struct LabeledLatLng: Decodable {
        let label: String?
        let lat: Double?
        let lng: Double?
    }
    
    // MARK: - Menu
    struct Menu: Decodable {
        let type: String?
        let label: String?
        let anchor: String?
        let url: String?
        let mobileURL: String?
        let externalURL: String?
        
        enum CodingKeys: String, CodingKey {
            case type, label, anchor, url
            case mobileURL = "mobileUrl"
            case externalURL = "externalUrl"
        }
    }
    
    // MARK: - Photos
    struct Photos: Decodable {
        let count: Int?
        let groups: [PhotosGroup]
    }
    
    // MARK: - PhotosGroup
    struct PhotosGroup: Decodable {
        let type: String?
        let name: String?
        let count: Int?
        let items: [FeaturedPhotosItem]?
    }
    
    // MARK: - Price
    struct Price: Decodable {
        let tier: Int?
        let message: String?
        let currency: String?
    }
    
    // MARK: - Stats
    struct Stats: Decodable {
        let tipCount: Int?
        let usersCount: Int?
        let checkinsCount: Int?
    }
    
    // MARK: - SuggestedBounds
    struct SuggestedBounds: Decodable {
        let ne: Ne
        let sw: Ne
    }
    
    // MARK: - Ne
    struct Ne: Decodable {
        let lat: Double
        let lng: Double
    }
    
    // MARK: - Warning
    struct Warning: Decodable {
        let text: String?
    }
}
