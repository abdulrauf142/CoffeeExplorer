//
//  VenueListViewModel.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//


import Combine
import Foundation
import CoreLocation

final class VenueListViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var venues: [Venue] = []
    
    private let useCase: VenueListUseCase
    private var cancellables = Set<AnyCancellable>()
    private var pageOffset = 0
    private var totalResult = 0
    
    var hasMoreRows: Bool {
        pageOffset < totalResult
    }
    // MARK: - Initializer
    init(with useCase: VenueListUseCase = VenueListUseCase()) {
        self.useCase = useCase
    }
    
    // MARK: - Functions
    func fetchVenue(coordinate: Coordinate) {
        useCase.fetchVenues(coordinate: coordinate, offset: pageOffset)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.totalResult = response.totalResults
                self.venues = self.venues + response.venues
                self.pageOffset += 20
                
            }
            .store(in: &cancellables)
    }
}
