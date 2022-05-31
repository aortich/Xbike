//
//  MapViewController.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation
import UIKit
import MapKit

public class MapViewControllerImpl: UIViewController {
    struct Constants {
        static let stopwatchPadding: CGFloat = 8.0
    }
    var presenter: MapViewPresenter?
    var polyline: MKPolyline?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    
    private var floatView: FloatingTimerView?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current Ride"
        let addBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .done, target: self, action: #selector(addItem))
        self.navigationController?.navigationItem.rightBarButtonItem = addBarButtonItem
        self.navigationItem.rightBarButtonItem  = addBarButtonItem
        self.presenter = MapViewPresenter(view: self)
        self.setupViews()
    }
    
    @objc func addItem() {
        self.addTimerSubview()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupViews() {
        self.view.addSubview(mapView)
        self.mapView.delegate = self
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addTimerSubview() {
        if floatView != nil { return }
        let subView = FloatingTimerView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(subView)
        NSLayoutConstraint.activate([
            subView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -MapViewControllerImpl.Constants.stopwatchPadding),
            subView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            subView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87)
        ])
        
        self.floatView = subView
        self.floatView?.onClickStarted = self.startTimer(sender:)
        self.floatView?.onClickedFinish = self.endTimer(sender:)
    }
}

extension MapViewControllerImpl {
    func removeTimerSubview() {
        floatView?.removeFromSuperview()
        floatView = nil
    }
    
    func startTimer(sender: UIButton?) {
        self.presenter?.startTimer()
    }
    
    func endTimer(sender: UIButton?) {
        self.presenter?.stopTimer()
    }
    
    func setTimerElapsed(elapsed: String) {
        if floatView == nil { return }
        self.floatView?.updateTimer(elapsed)
    }
    
    func receivedInitialLocation(region: MKCoordinateRegion) {
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    
    func showPermissionDeniedError(_ alert: UIAlertController) {
        self.present(alert, animated: true)
    }
    
    func drawPath(routes: [CLLocationCoordinate2D]) {
        if(routes.isEmpty) { return }
        DispatchQueue.main.async {
            self.polyline = MKPolyline(coordinates: routes, count: routes.count)
            self.mapView.addOverlay(self.polyline!, level: .aboveRoads)
        }
    }
    
    func clearPath() {
        DispatchQueue.main.async {
            let overlays = self.mapView.overlays
            self.mapView.removeOverlays(overlays)
        }
    }
}

extension MapViewControllerImpl: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKGradientPolylineRenderer(overlay: overlay)
        renderer.setColors([
            UIColor(red: 0.02, green: 0.91, blue: 0.05, alpha: 1.00),
            UIColor(red: 1.00, green: 0.48, blue: 0.00, alpha: 1.00),
            UIColor(red: 1.00, green: 0.00, blue: 0.05, alpha: 1.00)], locations: [])
        renderer.lineCap = .round
        renderer.lineWidth = 3.0
        
        return renderer
    }
}

