//
//  NetworkManager.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Combine
import Foundation

protocol Fetchable {
    func fetch<T: Decodable>(using request: RequestBuildable) -> AnyPublisher<T, NetworkError>
}

struct NetworkManager: Fetchable {
    
    // MARK: - Properties
    private let session: URLSession
    
    // MARK: - Intializer
    init(with session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK:- Functions
    func fetch<T: Decodable>(using request: RequestBuildable) -> AnyPublisher<T, NetworkError> {
        
        do {
            let request = try request.build()
            return session.dataTaskPublisher(for: request)
                .tryMap { try self.validate($0.data, $0.response) }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    print(error)
                    switch error {
                    case is Swift.DecodingError:
                        return .decodingFailed
                    case let urlError as URLError:
                        return .session(error: urlError)
                    default:
                        return .unknown(error: error)
                    }
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: .nilRequest).eraseToAnyPublisher()
        }
    }
    
    func validate(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.badServerResponse }
        guard (200..<300).contains(httpResponse.statusCode) else { throw networkRequestError(data, httpResponse) }
        return data
    }
    
    func networkRequestError(_ data: Data, _ response: HTTPURLResponse) -> NSError {
        guard let response = try? JSONDecoder().decode(Server.VenueListResponse.self, from: data) else {
            return NetworkError.badServerResponse as NSError
        }
        return NSError(domain: "", code: response.meta.code,
                       userInfo: [NSLocalizedDescriptionKey: response.meta.errorDetail ?? ""])
      }
    
    struct Error: Decodable {
        let message: String
    }
}

