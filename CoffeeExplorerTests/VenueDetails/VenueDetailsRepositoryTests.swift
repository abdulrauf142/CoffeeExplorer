//
//  VenueDetailsRepositoryTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 19/11/2021.
//

import XCTest
import Combine
@testable import CoffeeExplorer

private class MockNetworkManger: Fetchable {
    var isSuccess = true
    func fetch<T: Decodable>(using request: RequestBuildable) -> AnyPublisher<T, NetworkError> {
        guard isSuccess else {
            return Fail(error: NetworkError.decodingFailed).eraseToAnyPublisher()
        }
        return Future <T, NetworkError> { promise in
            if self.isSuccess {
                promise(.success(self.venueDetailsResponse as! T))
            } else {
                promise(.failure(NetworkError.badServerResponse))
            }
        }.eraseToAnyPublisher()
    }
}

extension MockNetworkManger {
    var venueDetailsResponse: Server.VenueDetailsResponse {
        try! JSONDecoder().decode(Server.VenueDetailsResponse.self, from: File.venueDetailsReponse.data!)
    }
}

class VenueDetailsRepositoryTests: XCTestCase {
    
    private var repository: VenueDetailsRepositoryProtocol!
    private var networkManager: MockNetworkManger!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = MockNetworkManger()
        repository = VenueDetailsRepository(with: networkManager)
    }
    
    func testFetchVenue() {
        
        var response: Server.VenueDetailsResponse?
        var error: NetworkError?
        var cancellable: AnyCancellable?
        
        let expectation = expectation(description: "test.success.response.finished")
        cancellable = repository.fetchVenue(by: "id")
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
        XCTAssertNotNil(response?.response)
    }
    
    func testFetchVenueWhenFailed() {
        
        var response: Server.VenueDetailsResponse?
        var error: NetworkError?
        var cancellable: AnyCancellable?
        networkManager.isSuccess = false
        let expectation = expectation(description: "test.failed.response.finished")
        cancellable = repository.fetchVenue(by: "121")
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
        XCTAssertNotNil(error)
        XCTAssertNil(response)
    }
}
