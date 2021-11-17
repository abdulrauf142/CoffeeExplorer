//
//  UserDefaultWrapperTest.swift
//  CoffeeExplorerTests
//
//  Created by ar on 17/11/2021.
//


import XCTest
@testable import CoffeeExplorer

private class MockStorage: Storage {
    
    var values: [String: Any]
    init(values: [String: Any] = [:]) {
        self.values = values
    }

    func value(forKey key: String) -> Any? {
        return values[key]
    }

    func setValue(_ value: Any?, forKey key: String) {
        values[key] = value
    }
}

class UserDefaultWrapperTest: XCTestCase {
    
    @UserDefault(key: "has.seen.app.OnBoarding", defaultValue: false, storage: MockStorage())
    private var hasSeenAppOnBoarding: Bool
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func testHasSeenAppIntroduction() {
        hasSeenAppOnBoarding = true
        XCTAssertTrue(hasSeenAppOnBoarding)
    }
}

