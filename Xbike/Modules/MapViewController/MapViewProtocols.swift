//
//  MapViewProtocols.swift
//  Xbike
//
//  Created by Alberto Ortiz on 31/05/22.
//

import UIKit
import MapKit

protocol MapViewPresenter {
    func startTimer()
    func stopTimer()
    func saveRoute()
}

protocol MapViewController: UIViewController {
    func removeTimerSubview()
    func startTimer(sender: UIButton?)
    func endTimer(sender: UIButton?)
    func setTimerElapsed(elapsed: String)
    func receivedInitialLocation(region: MKCoordinateRegion)
    func showPermissionDeniedError(_ alert: UIAlertController)
    func drawPath(routes: [CLLocationCoordinate2D])
    func clearPath()
}
