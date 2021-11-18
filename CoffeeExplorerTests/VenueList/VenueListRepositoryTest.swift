//
//  VenueListRepositoryTest.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
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
                promise(.success(self.venueListResponse as! T))
            } else {
                promise(.failure(NetworkError.badServerResponse))
            }
            
        }.eraseToAnyPublisher()
    }
}

extension MockNetworkManger {
    var venueListResponse: Server.VenueListResponse {
        try! JSONDecoder().decode(Server.VenueListResponse.self, from: File.venueListResponse.data!)
    }
}

class VenueListRepositoryTest: XCTestCase {
    
    private var repository: VenueListRepositoryProtocol!
    private var networkManager: MockNetworkManger!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = MockNetworkManger()
        repository = VenueListRepository(with: networkManager)
    }
    
    func testFetchVenuesWhenSuccess() {
        
        var response: Server.VenueListResponse?
        var error: NetworkError?
        var cancellable: AnyCancellable?
        
        let expectation = expectation(description: "test.success.response.finished")
        cancellable = repository.fetchVenues(coordinate: Coordinate(lat: 1, lng: 2), offset: 0)
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
    
    func testFetchVenuesWhenFailed() {
        
        var response: Server.VenueListResponse?
        var error: NetworkError?
        var cancellable: AnyCancellable?
        networkManager.isSuccess = false
        let expectation = expectation(description: "test.failed.response.finished")
        cancellable = repository.fetchVenues(coordinate: Coordinate(lat: 1, lng: 2), offset: 0)
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
