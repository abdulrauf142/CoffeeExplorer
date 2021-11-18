//
//  NetworkManagerTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import XCTest
import Combine
import CoreLocation
@testable import CoffeeExplorer

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var request: VenueListRequest!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let query = VenueListQuery(corrrdinates: CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708))
        request = VenueListRequest(query: query)
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        networkManager = NetworkManager(with: URLSession(configuration: config))
        
        let url = try! request.build().url
        let reponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        MockURLProtocol.mocks[url!.path] = File.venueListResponse.data
        MockURLProtocol.response = reponse
    }
    
    func testFetchForError() {
     
        let url = try! request.build().url
        let reponse = HTTPURLResponse(url: url!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        MockURLProtocol.mocks[url!.path] = File.failedVenueListResponse.data
        MockURLProtocol.response = reponse
        
        
        let finished = expectation(description: "expectation.finished")
        let success = expectation(description: "expectation.success")
        let failed = expectation(description: "expectation.failure")
        
        success.isInverted = true
        finished.isInverted = true
        let publisher: AnyPublisher<Server.VenueListResponse, NetworkError> = networkManager.fetch(using: request)
            
        let cancelable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_):
                failed.fulfill()
            case .finished:
                finished.fulfill()
            }
        }) { response in
            success.fulfill()
        }
        wait(for: [failed, success, finished], timeout: 1.0)
        cancelable.cancel()
    }
    
    func testFetch() {
        
        let finished = expectation(description: "expectation.finished")
        let success = expectation(description: "expectation.success")
        let failed = expectation(description: "expectation.failure")
        
        failed.isInverted = true
        
        let publisher: AnyPublisher<Server.VenueListResponse, NetworkError> = networkManager.fetch(using: request)
            
        let cancelable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_):
                failed.fulfill()
            case .finished:
                finished.fulfill()
            }
        }) { response in
            success.fulfill()
        }
        wait(for: [failed, success, finished], timeout: 1.0)
        cancelable.cancel()
    }
}

