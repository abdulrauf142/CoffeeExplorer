//
//  VenueListViewModel.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//


import Combine
import Foundation
import CoreLocation

final class VenueListViewModel: BaseViewModel {
    
    // MARK: - Properties
    @Published var venues: [Venue] = []
    private let useCase: VenueListUseCase
    private var pageOffset = 0
    private var totalResult = 0
    
    var hasMoreRows: Bool {
        pageOffset < totalResult
    }
    // MARK: - initializer
    init(with useCase: VenueListUseCase = VenueListUseCase()) {
        self.useCase = useCase
    }
    
    // MARK: - Functions
    func fetchVenue(coordinate: Coordinate) {
        if venues.isEmpty { isLoading = true }
        useCase.fetchVenues(coordinate: coordinate, offset: pageOffset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self?.errorSubject.send(error)
                }
                self?.isLoading = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.totalResult = response.totalResults
                self.venues = self.venues + response.venues
                self.pageOffset += 20
                
            }
            .store(in: &subscriptions)
        bindErrorSubject()
    }
}
