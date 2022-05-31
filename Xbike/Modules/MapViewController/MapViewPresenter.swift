//
//  MapViewPresenter.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapViewPresenter {
    let view: MapViewControllerImpl
    var timer: Timer?
    var locations: [CLLocation]
    var finalTime: String = "00:00:00:0000"
    var finalDistance: String = "0.00"
    let locationProvider: LocationProvider
    
    var start: CFTimeInterval = 0
    var end: CFTimeInterval = 0
    
    init(view: MapViewControllerImpl) {
        self.view = view
        self.locations = []
        self.locationProvider = LocationProvider.shared
        locationProvider.addObserver(self)
        locationProvider.requestLocation()
    }
    
    func startTimer() {
        self.locations = []
        timer?.invalidate()
        timer = nil
        self.locationProvider.startLocationTracking()
        self.start = CFAbsoluteTimeGetCurrent()
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        let finalInterval =  CFAbsoluteTimeGetCurrent() - self.start
        self.finalDistance = "0.00 mts"
        if let firstLocation = self.locations.first,
           let finalLocation = self.locations.last {
            self.finalDistance = String(format: "%.2f mts", firstLocation.distance(from: finalLocation))
        }
        self.finalTime = getFormattedElapsed(elapsed: finalInterval)
        timer?.invalidate()
        timer = nil
        
        //let alert = saveAlert(self.finalTime, distance: self.finalDistance)
        
        self.view.removeTimerSubview()
        
        XbikeAlert.showAlertWithButtons(
            with: makeResultAttributedString(elapsed: self.finalTime, distance: self.finalDistance),
            on: self.view) {
                self.saveRoute()
            } onCancelled: {
                self.view.clearPath()
            }
        
        //self.view.present(alert, animated: true, completion: nil)
    }
    
    func saveRoute() {
        let dataSource = RouteDataSource.shared
        dataSource.addRoute(route: RouteCell.ViewModel(time: finalTime, distance: finalDistance))
        self.view.clearPath()
        XbikeAlert.showSimpleAlert(with: "Your progress has been correctly stored!", on: self.view)
    }
    
    private func getFormattedElapsed(elapsed: CFAbsoluteTime) -> String {
        let ms = elapsed.truncatingRemainder(dividingBy: 1) * 10000
        let seconds = elapsed.truncatingRemainder(dividingBy: 60)
        let minutes = elapsed / 60
        let hours = elapsed / 3600
       return String(format: "%02.f:%02.f:%02.f:%04.f", hours, minutes, seconds, ms)
    }
    
    private func makeResultAttributedString(elapsed: String, distance: String) -> NSAttributedString {
        let promptAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.navbarTitleFont ?? UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black]
        
        let dataAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.stopwatchFont ?? UIFont.systemFont(ofSize: 22),
            .foregroundColor: UIColor.black]

        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: "Your time was\n", attributes: promptAttributes))
        result.append(NSAttributedString(string: "\(elapsed)\n", attributes: dataAttributes))
        result.append(NSAttributedString(string: "Distance\n", attributes: promptAttributes))
        result.append(NSAttributedString(string: "\(distance)\n", attributes: dataAttributes))
        
        return result
    }
    
    @objc func updateTimer() {
        let interval = CFAbsoluteTimeGetCurrent() - self.start
        self.view.setTimerElapsed(elapsed: getFormattedElapsed(elapsed: interval))
    }
    
    private func locationAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "App needs location permitions enabled", message: "Do you wish to to enable location permissions from the settings screen?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open settings", style: .default) {_ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL) { success in
                    print("opened settings \(success)")
                }
            }
        }
        
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    private func saveAlert(_ elapsedTime: String, distance: String) -> UIAlertController {
        let alertController = UIAlertController(title: "", message: "Your time was \n \(elapsedTime) \n Distance \n \(distance)", preferredStyle: .alert)
        let storeAction = UIAlertAction(title: "Store", style: .default) {_ in
            self.saveRoute()
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .cancel) { _ in
            self.view.clearPath()
        }
        
        alertController.addAction(storeAction)
        alertController.addAction(deleteAction)
        return alertController
    }
    
    private func savedSuccessAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "", message: "Your progress has been correcly stored!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        return alertController
    }
}

extension MapViewPresenter: LocationObserver {
    func didRecieveLocations(_ locations: [CLLocation]) {
        self.updateViewRegion(locations)
        if(timer == nil) { return }
        if let location = locations.first {
            self.locations.append(location)
        }
        self.view.drawPath(routes: self.locations.map { $0.coordinate })
    }
    
    func updateViewRegion(_ locations: [CLLocation]) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = locations.last?.coordinate ?? CLLocationCoordinate2D(latitude: -19, longitude: 19)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.view.receivedInitialLocation(region: region)
    }
    
    func locationError(_ error: Error) {
        print(error)
    }
    
    func authorizationDenied() {
        self.view.showPermissionDeniedError(locationAlert())
    }
}
