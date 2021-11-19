//
//  VenueDetailsUseCase.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Combine
import Foundation

struct VenueDetailsUseCase {
    // MARK: - properties
    private let repository: VenueDetailsRepositoryProtocol
    // MARK: - initializers
    init(with repository: VenueDetailsRepositoryProtocol = VenueDetailsRepository()) {
        self.repository = repository
    }
}

extension VenueDetailsUseCase {
    func fetchVenue(by id: String) -> AnyPublisher<VenueModel, NetworkError> {
        repository.fetchVenue(by: id)
            .map { response in
                VenueModel(venue: response.response.venue)
            }
            .eraseToAnyPublisher()
    }
}
