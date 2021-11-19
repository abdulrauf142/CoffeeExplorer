//
//  VenueDetailsRepository.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Combine

protocol VenueDetailsRepositoryProtocol {
    func fetchVenue(by id: String) -> AnyPublisher<Server.VenueDetailsResponse, NetworkError>
}

struct VenueDetailsRepository {
    // MARK: - Properties
    private let network: Fetchable
    // MARK: - initializers
    init(with network: Fetchable = NetworkManager()) {
        self.network = network
    }
}

extension VenueDetailsRepository: VenueDetailsRepositoryProtocol {
    
    func fetchVenue(by id: String) -> AnyPublisher<Server.VenueDetailsResponse, NetworkError> {
        let request = VenueDetailsRequest(venueID: id)
        return network.fetch(using: request)
    }
}
