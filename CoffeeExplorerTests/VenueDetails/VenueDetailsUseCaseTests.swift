//
//  VenueDetailUseCaseTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 19/11/2021.
//

import XCTest
import Combine
@testable import CoffeeExplorer

private class MockVenueDetailsRepository: VenueDetailsRepositoryProtocol {
    func fetchVenue(by id: String) -> AnyPublisher<Server.VenueDetailsResponse, NetworkError> {
        return Future <Server.VenueDetailsResponse, NetworkError> { promise in
            promise(.success(self.venueDetailsResponse))
        }.eraseToAnyPublisher()
    }
}

extension MockVenueDetailsRepository {
    var venueDetailsResponse: Server.VenueDetailsResponse {
        try! JSONDecoder().decode(Server.VenueDetailsResponse.self, from: File.venueDetailsReponse.data!)
    }
}

class VenueDetailsUseCaseTests: XCTestCase {
    
    private var repository: MockVenueDetailsRepository!
    private var useCase: VenueDetailsUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockVenueDetailsRepository()
        useCase = VenueDetailsUseCase(with: repository)
    }
    
    func testFetchVenuesWhenSuccess() {
        
        var response: Server.VenueDetailsResponse?
        var error: NetworkError?
        var cancellable: AnyCancellable?
        
        let expectation = expectation(description: "test.success.response.finished")
        cancellable = useCase.fetchVenue(by: "11")
            .sink { result in
                switch result {
                case .failure(let err):
                    error = err
                case .finished:
                    break
                }
                
                expectation.fulfill()
                cancellable?.cancel()
            } receiveValue: { value in
                response = value
            }
        
        waitForExpectations(timeout: 0.5)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        XCTAssertNotNil(response?.response.venue)
    }
}

