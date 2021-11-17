//
//  RequestBuildable.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation

protocol RequestBuildable {
    
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    
    // MARK: Optional values
    var parameters: Parameters { get }
    var httpHeader: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    var baseUrl: URL { get }
}

// MARK: Default bahviour for optinal property
extension RequestBuildable {
    
    var baseUrl: URL {
        guard let url = URL(string: Network.environmentUrl)
        else {
            fatalError("unable to create the base URL")
        }
        return url
    }
    
    var httpMethod: HTTPMethod { return .get }
    var httpHeader: HTTPHeaders? { return nil }
    var encoding: ParameterEncoding { return .urlEncoding }
    
    func build() throws -> URLRequest {
        
        var request = URLRequest(url: path.isEmpty ? baseUrl : baseUrl.appendingPathComponent(path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: RequestTimeout.thirty.rawValue)
        
        request.httpMethod = httpMethod.rawValue
        try encoding.encode(urlRequest: &request, params: parameters)
        return request
    }
}
