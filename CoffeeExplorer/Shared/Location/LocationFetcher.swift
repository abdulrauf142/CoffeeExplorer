//
//  LocationFetcher.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Foundation
import CoreLocation

protocol LocationFetcherDelegate: AnyObject {
    func locationFetcher(_ fetcher: LocationFetcher, didFailWithError error: Error)
    func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation])
    func locationFetcher(_ fetcher: LocationFetcher, didChangeAuthorization status: CLAuthorizationStatus)
}

protocol LocationFetcher {
    // MARK: - CLLocationManager Properties
    var distanceFilter: CLLocationDistance { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var locationFetcherDelegate: LocationFetcherDelegate? { get set }
    
    // MARK: - CLLocationManager Methods
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

extension CLLocationManager: LocationFetcher {
    var locationFetcherDelegate: LocationFetcherDelegate? {
        get { return delegate as! LocationFetcherDelegate? }
        set { delegate = newValue as! CLLocationManagerDelegate? }
    }
}
