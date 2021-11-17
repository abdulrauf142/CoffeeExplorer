//
//  ParameterEncoding.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

extension String {
    static let contentType = "Content-Type"
}

protocol ParameterEncodable {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    
    func encode(urlRequest: inout URLRequest, params: Parameters?) throws {
        
        guard let parameters = params else { throw NetworkError.noParameterToEncode }
        
        switch self {
        case .urlEncoding:
            try URLEncoder().encode(urlRequest: &urlRequest, with: parameters)
        case .jsonEncoding:
            try JSONEncoder(with: .prettyPrinted).encode(urlRequest: &urlRequest, with: parameters)
        }
    }
}
