//
//  JSONEncoderTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import XCTest
@testable import CoffeeExplorer

class JSONEncoderTests: XCTestCase {
    
    let encoding = ParameterEncoding.jsonEncoding
    var request = URLRequest(url:  URL(string: "https://api.foursquare.com/venue/explorer")!)
    
    func testWhenParameterNil() {
        XCTAssertThrowsError(try encoding.encode(urlRequest: &request, params: nil)) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.noParameterToEncode)
        }
    }
    
    func testParameterEncoding() {
        try! encoding.encode(urlRequest: &request, params: ["section": "coffee", "offset" : 1])
        XCTAssertNotNil(request.url)
        XCTAssertTrue(request.value(forHTTPHeaderField: "Content-Type")! == "application/json")
        XCTAssertTrue(request.httpBody != nil)
    }
}
