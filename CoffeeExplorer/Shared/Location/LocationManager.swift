//
//  LocationManager.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    
    @Published var coordinate: CLLocationCoordinate2D? {
        willSet { objectWillChange.send() }
    }
    
    private var locationManager: LocationFetcher
    
    init(locationFetcher: LocationFetcher = CLLocationManager()) {
        locationManager = locationFetcher
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()
        locationManager.locationFetcherDelegate = self
    }
    
    func requestForAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationFetcher(manager, didChangeAuthorization: status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationFetcher(manager, didUpdateLocations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         locationFetcher(manager, didFailWithError: error)
    }
}

extension LocationManager : LocationFetcherDelegate {
    
    func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordinate = location.coordinate
    }
    
    func locationFetcher(_ fetcher: LocationFetcher, didFailWithError error: Error) {
        debugPrint("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationFetcher(_ fetcher: LocationFetcher, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
}
