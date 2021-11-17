//
//  LocationManagerTests.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import XCTest
import CoreLocation
@testable import CoffeeExplorer

class MockLocationFetcher: LocationFetcher {
    
    enum MockError: Error {
        case mockLocationError
    }
    
    weak var locationFetcherDelegate: LocationFetcherDelegate?
    var distanceFilter: CLLocationDistance = 0.0
    var desiredAccuracy: CLLocationAccuracy = 0.0
    
    var handlePermissionRequest: (() -> CLAuthorizationStatus)?
    var handleRequestLocation: (() -> CLLocation)?
    
    func startUpdatingLocation() { }
    func stopUpdatingLocation() { }
    
    func requestLocation() {
        guard let location = handleRequestLocation?() else { return }
        locationFetcherDelegate?.locationFetcher(self, didUpdateLocations: [location])
    }
    
    func faileUpdatingLocation() {
         locationFetcherDelegate?.locationFetcher(self, didFailWithError: MockError.mockLocationError)
    }
    
    func requestWhenInUseAuthorization() {
        let status = handlePermissionRequest?() ?? .notDetermined
        locationFetcherDelegate?.locationFetcher(self, didChangeAuthorization: status)
    }

}

class LocationManagerTests: XCTestCase {
    
    private var locationManager: LocationManager!
    private var locationFetcher: MockLocationFetcher!
    
    override func setUpWithError() throws {
        locationFetcher = MockLocationFetcher()
        locationManager = LocationManager(locationFetcher: locationFetcher)
        try super.setUpWithError()
    }
    
    func testCoordinate() {
        let location = CLLocation(latitude: 25.2048, longitude: 55.2708)
        locationFetcher.handleRequestLocation = {
            return location
        }
        
        XCTAssertEqual(locationFetcher.distanceFilter, kCLDistanceFilterNone)
        XCTAssertEqual(locationFetcher.desiredAccuracy, kCLLocationAccuracyBest)
        
        locationManager.locationFetcher(locationFetcher, didUpdateLocations: [location])
        XCTAssertEqual(locationManager.coordinate?.latitude, location.coordinate.latitude)
        XCTAssertEqual(locationManager.coordinate?.longitude, location.coordinate.longitude)
    }
    
    func testCoordinateWhenLocationArrayEmpty() {
        locationManager.locationFetcher(locationFetcher, didUpdateLocations: [])
        XCTAssertNil(locationManager.coordinate)
    }
    
    func testAuthorizationStatus() {
        let location = CLLocation(latitude: 25.2048, longitude: 55.2708)
        locationFetcher.handleRequestLocation = {
            return location
        }
        
        locationFetcher.handlePermissionRequest = {
            return .authorizedWhenInUse
        }
        locationManager.locationFetcher(locationFetcher, didChangeAuthorization: .authorizedWhenInUse)
        XCTAssertEqual(locationManager.status, .authorizedWhenInUse)
    }
}
