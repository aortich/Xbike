//
//  LocationStrategy.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import CoreLocation
import UIKit

class LocationProvider : NSObject, CLLocationManagerDelegate {
    static let shared = LocationProvider()
    private let locationManager: CLLocationManager
    private var observers = [ObjectIdentifier : Observation]()
    private var state: LocationProvider.State
    
    private override init() {
        locationManager = CLLocationManager()
        state = .idle
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    func determineAuthStatusAction(_ status: CLAuthorizationStatus, requestLocation: () -> Void) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
        case .restricted:
            self.state = .disallowed
            self.stateDidChange()
            
        case .denied:
            self.state = .disallowed
            self.stateDidChange()
            
        case .authorizedAlways:
            requestLocation()
            
        case .authorizedWhenInUse:
            requestLocation()
            
        case .authorized:
            requestLocation()
            
        default:
            self.state = .disallowed
            self.stateDidChange()
        }
    }
    
    func startLocationTracking() {
        self.determineAuthStatusAction(locationManager.authorizationStatus) {
            locationManager.startUpdatingLocation()
        }
    }
    
    func requestLocation() {
        self.determineAuthStatusAction(locationManager.authorizationStatus) { locationManager.requestLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.determineAuthStatusAction(manager.authorizationStatus) {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.state = .updatedLocation(locations)
        self.stateDidChange()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.state = .failed(error)
        self.stateDidChange()
    }
}


extension LocationProvider {
    struct Observation {
        weak var observer: LocationObserver?
    }
    
    func addObserver(_ observer: LocationObserver) {
        let id = ObjectIdentifier(observer)
        self.observers[id] = Observation(observer: observer)
    }
    
    func removeObserver(_ observer: LocationObserver) {
        let id = ObjectIdentifier(observer)
        self.observers.removeValue(forKey: id)
    }
    
    
    func stateDidChange() {
        for (id, observation) in observers {
            guard let observer = observation.observer else {
                observers.removeValue(forKey: id)
                continue
            }
            
            switch state {
            case .idle:
                fallthrough
            case .disallowed:
                observer.authorizationDenied()
            case .updatedLocation(let locations):
                observer.didRecieveLocations(locations)
            case .failed(let error):
                observer.locationError(error)
            }
        }
    }
}

private extension LocationProvider {
    enum State {
        case idle
        case disallowed
        case updatedLocation([CLLocation])
        case failed(Error)
    }
}




