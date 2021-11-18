//
//  VenueListRequestTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import XCTest
import CoreLocation
@testable import CoffeeExplorer

class VenueListRequestTests: XCTestCase {
    
    var request: VenueListRequest!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let coordinate = CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708)
        request = VenueListRequest(query: VenueListQuery(corrrdinates: coordinate))
    }
    
    func testVenueExpolreEndpoint() {
        
        XCTAssertEqual(request.baseUrl.absoluteString, Network.environmentUrl)
        XCTAssertEqual(request.httpMethod, HTTPMethod.get)
        XCTAssertEqual(request.path, "/v2/venues/explore")
        XCTAssertNotNil(request.parameters)
        
        let throwExpection = expectation(description: "throw.build.request")
        
    
        do {
            let req = try request!.build()
            XCTAssertTrue(req.url!.absoluteString.contains("limit=20"))
            XCTAssertTrue(req.url!.absoluteString.contains("ll=25.2048,55.2708"))
            XCTAssertTrue(req.url!.absoluteString.contains("venuePhotos=1"))
            throwExpection.fulfill()
        } catch {
            print("error \(error.localizedDescription)")
        }
        wait(for: [throwExpection], timeout: 1.0)
    }
}
