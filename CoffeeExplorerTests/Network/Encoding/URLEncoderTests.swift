//
//  URLEncoderTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import XCTest
@testable import CoffeeExplorer

class URLEncoderTests: XCTestCase {
    
    let encoding = ParameterEncoding.urlEncoding
    var request = URLRequest(url:  URL(string: "https://api.foursquare.com/venue/explorer")!)
    
    func testWhenParameterNil() {
        
        XCTAssertThrowsError(try encoding.encode(urlRequest: &request, params: nil)) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.noParameterToEncode)
        }
    }
    
    func testParameterEncoding() {
        try! encoding.encode(urlRequest: &request, params: ["section": "coffee", "offset" : 1])
        XCTAssertNotNil(request.url)
        XCTAssertTrue(request.value(forHTTPHeaderField: "Content-Type")! == "application/x-www-form-urlencoded; charset=utf-8")
        XCTAssertTrue(request.url!.absoluteString.contains("section=coffee"))
        XCTAssertTrue(request.url!.absoluteString.contains("offset=1"))
    }
}
