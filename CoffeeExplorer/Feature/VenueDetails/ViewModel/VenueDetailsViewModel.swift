//
//  VenueDetailsViewModel.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Combine
import Foundation

final class VenueDetailsViewModel: BaseViewModel {

    // MARK: - properties
    @Published var venue: VenueModel?
    private let trimmedVenue: Venue
    private let useCase: VenueDetailsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    var photoURL: URL? {
        guard let venue = venue else {
            return trimmedVenue.thumbnail
        }
        return venue.photoURL
    }
    
    var venueName: String { trimmedVenue.name }
    var venueAddress: String { venue?.address ?? "unknown" }
    var venueOpenStatus: String { venue?.openStatus ?? "unknown" }
    var venueDescription: String { venue?.description ?? "unknown" }
    var recommendations: [VenueModel.Recommendation] { venue?.recommendations ?? [] }
    
    init(useCase: VenueDetailsUseCase = VenueDetailsUseCase(), venue: Venue) {
        self.useCase = useCase
        self.trimmedVenue = venue
    }

    func fetchVenueDetails() {
        isLoading = true
        useCase.fetchVenue(by: trimmedVenue.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .finished: break
                case .failure(let error):
                    self.errorSubject.send(error)
                }
                self.isLoading = false
                
            } receiveValue: { [weak self] venueModel in
                self?.venue = venueModel
            }
            .store(in: &cancellables)

    }
}
