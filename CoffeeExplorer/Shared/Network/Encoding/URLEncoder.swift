//
//  URLEncoder.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

fileprivate extension String {
    static let urlFormEncoded = "application/x-www-form-urlencoded; charset=utf-8"
}

struct URLEncoder: ParameterEncodable {
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.invalidURL }
        
        if var components = URLComponents(url: url,
                                          resolvingAgainstBaseURL: false), !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
            urlRequest.url = components.url
        }
        
        if urlRequest.value(forHTTPHeaderField: .contentType) == nil {
            urlRequest.setValue(.urlFormEncoded, forHTTPHeaderField: .contentType)
        }
    }
}
