//
//  MapViewConfigurator.swift
//  Xbike
//
//  Created by Alberto Ortiz on 31/05/22.
//

import Foundation

class MapViewConfigurator {
    init() {}
    
    func makeMapViewController() -> MapViewController {
        let viewController = MapViewControllerImpl()
        let presenter = MapViewPresenterImpl(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
