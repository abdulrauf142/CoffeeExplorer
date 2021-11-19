//
//  VenueDetailsRequestTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 19/11/2021.
//

import XCTest
import Combine
@testable import CoffeeExplorer

class VenueDetailsRequestTests: XCTestCase {
    
    var request: VenueDetailsRequest!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        request = VenueDetailsRequest(venueID: "test")
    }
    
    func testVenueDetailsEndpoint() {
        
        XCTAssertEqual(request.baseUrl.absoluteString, Network.environmentUrl)
        XCTAssertEqual(request.httpMethod, HTTPMethod.get)
        XCTAssertEqual(request.path, "/v2/venues/test")
        XCTAssertNotNil(request.parameters)
    }
}
