//
//  VenueListRepository.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Combine
import CoreLocation

protocol VenueListRepositoryProtocol {
    func fetchVenues(coordinate: Coordinate, offset: Int) -> AnyPublisher<Server.VenueListResponse, NetworkError>
}

struct VenueListRepository {
    
    // MARK: - Properties
    private let network: Fetchable
    
    // MARK: - Intializers
    init(with network: Fetchable = NetworkManager()) {
        self.network = network
    }
}

extension VenueListRepository: VenueListRepositoryProtocol {
    
    func fetchVenues(coordinate: Coordinate, offset: Int) -> AnyPublisher<Server.VenueListResponse, NetworkError> {
        network.fetch(using: VenueListRequest(query: VenueListQuery(offset: offset, coordinate: coordinate)))
    }
}
