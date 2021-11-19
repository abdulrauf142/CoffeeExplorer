//
//  VenueListViewModel.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import XCTest
import Combine
@testable import CoffeeExplorer

class VenueListViewModelTests: XCTestCase {
    
    private var cancellable: AnyCancellable?
    private var viewModel: VenueListViewModel!
    private var repository: MockVenueListRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockVenueListRepository()
        viewModel = VenueListViewModel(with: VenueListUseCase(with: repository))
    }
    
    func testFetchVenue() {
        
        let expectation = expectation(description: "test.success.response.finished")
        expectation.assertForOverFulfill = false
        viewModel.fetchVenue(coordinate: Coordinate(lat: 1, lng: 2))
        cancellable = viewModel.$venues.sink { venues in
            guard venues.count > 0 else { return }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(viewModel.venues.count > 0)
    }
    
    func testFetchVenueFailed() {
        repository.isSuccess = false
        let expectation = expectation(description: "test.failed.response.finished")
        expectation.assertForOverFulfill = false
        viewModel.fetchVenue(coordinate: Coordinate(lat: 1, lng: 2))
        cancellable = viewModel.$showError.sink { success in
            guard success == true else { return }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(viewModel.venues.count == 0)
        XCTAssertEqual(viewModel.errorMessage, "KEY_NETWORK_JSON_PARSING_FAILED")
    }
}
