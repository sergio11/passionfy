//
//  LocationService.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 20/12/24.
//

import Foundation
import CoreLocation

// Protocol to define the listener methods for location updates, authorization status changes, and errors
protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation, city: String, country: String)
    func didChangeAuthorizationStatus(_ status: CLAuthorizationStatus)
    func didFailWithError(_ error: Error)
}

// Service responsible for managing location updates and reverse geocoding
class LocationService: NSObject {
    private let locationManager = CLLocationManager() // Manages location-related events
    private let geocoder = CLGeocoder() // Used for reverse geocoding

    private var currentLocation: CLLocation? // Stores the current location
    private var city: String = "" // Stores the resolved city name
    private var country: String = "" // Stores the resolved country name

    // Delegate to notify about location-related updates and errors
    weak var delegate: LocationServiceDelegate?
    
    // Initializer sets up the location manager
    override init() {
        super.init()
        locationManager.delegate = self // Set this service as the delegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Set high accuracy
        print("[LocationService] Initialized")
    }
    
    // Requests permission to access the user's location when the app is in use
    func requestPermission() {
        print("[LocationService] Requesting location permissions...")
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Starts receiving location updates
    func startUpdatingLocation() {
        print("[LocationService] Starting location updates...")
        locationManager.startUpdatingLocation()
    }
    
    // Stops receiving location updates
    func stopUpdatingLocation() {
        print("[LocationService] Stopping location updates...")
        locationManager.stopUpdatingLocation()
    }
    
    // Performs reverse geocoding to get the city and country names from a CLLocation
    private func reverseGeocode(location: CLLocation) {
        print("[LocationService] Reverse geocoding for location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else {
                print("[LocationService] Self is nil during reverse geocoding")
                return
            }
            if let error = error {
                print("[LocationService] Error in reverse geocoding: \(error.localizedDescription)")
                self.delegate?.didFailWithError(error)
                return
            }
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    // Extract city and country from the placemark
                    self.city = placemark.locality ?? "Unknown City"
                    self.country = placemark.country ?? "Unknown Country"
                    print("[LocationService] Geocoding result: City - \(self.city), Country - \(self.country)")
                    
                    // Notify the delegate of the updated location and resolved details
                    if let currentLocation = self.currentLocation {
                        self.delegate?.didUpdateLocation(currentLocation, city: self.city, country: self.country)
                    }
                }
            } else {
                print("[LocationService] No placemarks found during reverse geocoding")
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    // Called when the location manager receives updated location data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("[LocationService] Location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            DispatchQueue.main.async {
                // Update the current location and trigger reverse geocoding
                self.currentLocation = location
                self.reverseGeocode(location: location)
            }
        } else {
            print("[LocationService] didUpdateLocations called with no valid locations")
        }
    }
    
    // Called when the authorization status changes (e.g., user grants or denies permission)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        print("[LocationService] Authorization status changed: \(status.rawValue)")
        DispatchQueue.main.async {
            // Notify the delegate of the new authorization status
            self.delegate?.didChangeAuthorizationStatus(status)
        }
    }
    
    // Called when the location manager encounters an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LocationService] Failed with error: \(error.localizedDescription)")
        DispatchQueue.main.async {
            // Notify the delegate of the error
            self.delegate?.didFailWithError(error)
        }
    }
}


