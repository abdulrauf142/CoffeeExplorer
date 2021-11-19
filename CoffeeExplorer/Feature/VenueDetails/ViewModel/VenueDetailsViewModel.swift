//
//  VenueDetailsViewModel.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import Combine
import Foundation

final class VenueDetailsViewModel: ObservableObject {

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
        useCase.fetchVenue(by: trimmedVenue.id)
            .receive(on: DispatchQueue.main)
            .sink { result in

                switch result {
                case .finished:
                    print("fetchCompleteVenue")
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }

            } receiveValue: { [weak self] venueModel in
                self?.venue = venueModel
            }
            .store(in: &cancellables)

    }
}
