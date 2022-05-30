//
//  LocationObserver.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation
import CoreLocation

protocol LocationObserver: AnyObject {
    func didRecieveLocations(_ locations: [CLLocation])
    func locationError(_ error: Error)
    func authorizationDenied()
}
