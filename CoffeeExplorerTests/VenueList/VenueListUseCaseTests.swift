//
//  VenueListUseCaseTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import XCTest
import Combine
@testable import CoffeeExplorer

class MockVenueListRepository: VenueListRepositoryProtocol {
    var isSuccess = true
    func fetchVenues(coordinate: Coordinate, offset: Int) -> AnyPublisher<Server.VenueListResponse, NetworkError> {
        guard isSuccess else {
            return Fail(error: NetworkError.decodingFailed).eraseToAnyPublisher()
        }
        return Future <Server.VenueListResponse, NetworkError> { promise in
            if self.isSuccess {
                promise(.success(self.venueListResponse))
            } else {
                promise(.failure(NetworkError.badServerResponse))
            }
            
        }.eraseToAnyPublisher()
    }
}

extension MockVenueListRepository {
    var venueListResponse: Server.VenueListResponse {
        try! JSONDecoder().decode(Server.VenueListResponse.self, from: File.venueListResponse.data!)
    }
}

class VenueListUseCaseTest: XCTestCase {
    
    private var repository: MockVenueListRepository!
    private var useCase: VenueListUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockVenueListRepository()
        useCase = VenueListUseCase(with: repository)
    }
    
    func testFetchVenuesWhenSuccess() {
        
        var response: VenueListResponse?
        var error: NetworkError?
        var cancellable: AnyCancellable?
        
        let expectation = expectation(description: "test.success.response.finished")
        cancellable = useCase.fetchVenues(coordinate: Coordinate(lat: 1, lng: 2), offset: 0)
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
        XCTAssertNotNil(response?.venues)
    }
    
    func testFetchVenuesWhenFailed() {
        
        var response: VenueListResponse?
        var error: NetworkError?
        var cancellable: AnyCancellable?
        repository.isSuccess = false
        let expectation = expectation(description: "test.failed.response.finished")
        cancellable = useCase.fetchVenues(coordinate: Coordinate(lat: 1, lng: 2), offset: 0)
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
