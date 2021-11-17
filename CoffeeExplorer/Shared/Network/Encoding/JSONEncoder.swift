//
//  JSONEncoder.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

fileprivate extension String {
    static let jsonEncoded = "application/json"
}

struct JSONEncoder: ParameterEncodable {
    
    private let options: JSONSerialization.WritingOptions
    init(with options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: options)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: .contentType) == nil {
                urlRequest.setValue(.jsonEncoded, forHTTPHeaderField: .contentType)
            }
        } catch {
            throw NetworkError.parameterEncodingFailed
        }
    }
}
