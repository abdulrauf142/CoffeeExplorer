//
//  VenueModelTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 19/11/2021.
//

import XCTest
import Combine
@testable import CoffeeExplorer

class VenueModelTests: XCTestCase {
    
    private var repository: MockVenueDetailsRepository!
    private var useCase: VenueDetailsUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockVenueDetailsRepository()
        useCase = VenueDetailsUseCase(with: repository)
    }
    
    func testVenueModelMapping() {
        var model: VenueModel?
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
                model = value
            }
        
        waitForExpectations(timeout: 0.5)
        XCTAssertNil(error)
        XCTAssertEqual(model!.recommendations.first!.date, "Aug 15 2013")
        XCTAssertEqual(model!.recommendations.first!.user.fullName, "Alanoud ?")
        XCTAssertEqual(model!.photoURL, URL(string: "https://fastly.4sqi.net/img/general/431x720/y0-7DT9GIaDmzzEZqGk78h7nBixq8O3thT4q6RQOjkE.jpg")!)
        XCTAssertEqual(model!.name, "Khan Murjan (خان مرجان)")
        XCTAssertEqual(model!.description, "At the heart of the souk is an exquisite marble courtyard, offering an oasis of cool serenity, yet open to the sky. The Umawi architecture provides an ornate backdrop to the social core of the souk, where people can gather and dine,")
        XCTAssertTrue(model!.recommendations.count > 0)
    }
}
