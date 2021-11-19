//
//  VenueDetailsViewModelTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 19/11/2021.
//

import XCTest
import Combine
@testable import CoffeeExplorer

class VenueDetailsViewModelTests: XCTestCase {
    
    private var repository: MockVenueDetailsRepository!
    private var useCase: VenueDetailsUseCase!
    private var viewModel: VenueDetailsViewModel!
    private var cancellable: AnyCancellable?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockVenueDetailsRepository()
        viewModel = VenueDetailsViewModel(useCase: VenueDetailsUseCase(with: repository), venue: Venue(with: venueListResponse.response.groups!.first!.items!.first!.venue))
    }
    
    func testViewModelEmptyState() {
        XCTAssertEqual(viewModel.photoURL, URL(string: "https://fastly.4sqi.net/img/general/64x64/y0-7DT9GIaDmzzEZqGk78h7nBixq8O3thT4q6RQOjkE.jpg")!)
        XCTAssertEqual(viewModel.venueName, "Khan Murjan (خان مرجان)")
        XCTAssertEqual(viewModel.venueDescription, "unknown")
        XCTAssertTrue(viewModel.recommendations.count == 0)
    }
    
    func testViewModelWithVenue() {
        
        let expectation = expectation(description: "test.success.response.finished")
        expectation.assertForOverFulfill = false
        
        viewModel.fetchVenueDetails()
        cancellable = viewModel.$venue
            .sink { venue in
                guard let _ = venue else {
                    return
                }
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(self.viewModel.photoURL, URL(string: "https://fastly.4sqi.net/img/general/431x720/y0-7DT9GIaDmzzEZqGk78h7nBixq8O3thT4q6RQOjkE.jpg")!)
        XCTAssertEqual(self.viewModel.venueName, "Khan Murjan (خان مرجان)")
        XCTAssertEqual(self.viewModel.venueDescription, "At the heart of the souk is an exquisite marble courtyard, offering an oasis of cool serenity, yet open to the sky. The Umawi architecture provides an ornate backdrop to the social core of the souk, where people can gather and dine,")
        XCTAssertTrue(self.viewModel.recommendations.count > 0)
       
    }

}

fileprivate extension VenueDetailsViewModelTests {
    var venueListResponse: Server.VenueListResponse {
        try! JSONDecoder().decode(Server.VenueListResponse.self, from: File.venueListResponse.data!)
    }
}
