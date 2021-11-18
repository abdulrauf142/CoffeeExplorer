//
//  VenueListUseCase.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Combine
import CoreLocation

struct VenueListUseCase {
    
    // MARK: - Properties
    private let repository: VenueListRepositoryProtocol
    
    // MARK: - Initializer
    init(with repository: VenueListRepositoryProtocol = VenueListRepository()) {
        self.repository = repository
    }
}

extension VenueListUseCase {
    func fetchVenues(coordinate: Coordinate, offset: Int) -> AnyPublisher<VenueListResponse, NetworkError> {
        repository.fetchVenues(coordinate: coordinate, offset: offset)
            .map { VenueListResponse(with: $0) }
            .eraseToAnyPublisher()
    }
}
