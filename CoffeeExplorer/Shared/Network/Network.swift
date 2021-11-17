//
//  Network.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum RequestTimeout: TimeInterval {
    case fifteen = 15.0
    case thirty = 30.0
}

struct Network {
    
    private enum Environment {
        case staging
        case production
        
        var url: String {
            switch self {
            case .staging, .production: // TODO: - Production URL Needs to updated
                return "https://api.foursquare.com"
            }
        }
    }
    
    static let environmentUrl = Environment.staging.url
    static var fourSquareConfig: FoursquareConfig = .default
}

struct FoursquareConfig {
    let clientID: String
    let clientSecret: String
    let version: String
    
    static let `default` = FoursquareConfig(clientID: "4THX0X2VG2QU0VXWEZTUUA5HDRLD1MYDRXQZU5KAPT5CTVJF",
                                            clientSecret: "RZVE20W4ZRQKLO3NQSUDJFZEV1LVJGZI0U4PDW2LXZBUGZU4",
                                            version: "20193112")
}


enum NetworkError: LocalizedError {
    
    case invalidURL
    case noParameterToEncode
    case parameterEncodingFailed
    case nilRequest
    case decodingFailed
    case noRecordFound // TODO: Error segregation
    case badServerResponse
    case session(error: URLError)
    case unknown(error: Error)
    
    var errorDescription: String {
        switch self {
        case .nilRequest:
            return "KEY_NETWORK_NIL_REQUEST"
        case .decodingFailed:
            return "KEY_NETWORK_JSON_PARSING_FAILED"
        case .invalidURL:
            return "KEY_NETWORK_INVALID_URL"
        case .noParameterToEncode:
            return "KEY_NETWORK_PARAMETERS_NIL"
        case .parameterEncodingFailed:
            return "KEY_NETWORK_PARAMETER_ENCODING_FAILED"
        case .noRecordFound:
            return "KEY_NO_RECORD_FOUND"
        case .badServerResponse:
            return "KEY_NETWORK_ERROR"
        case .unknown(let error):
            return error.localizedDescription
        case .session(let error):
            return error.localizedDescription
        }
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.nilRequest, .nilRequest),
             (.decodingFailed, .decodingFailed),
             (.invalidURL, .invalidURL),
             (.noParameterToEncode, .noParameterToEncode),
             (.parameterEncodingFailed, .parameterEncodingFailed):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.session(let lhsError), .session(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
