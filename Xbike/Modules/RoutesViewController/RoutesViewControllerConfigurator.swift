//
//  RouteViewControllerConfigurator.swift
//  Xbike
//
//  Created by Alberto Ortiz on 31/05/22.
//

import Foundation

class RoutesViewControllerConfigurator {
    init() {}
    
    func makeRoutesViewController() -> RoutesViewControllerImpl {
        let viewController = RoutesViewControllerImpl()
        let presenter = RoutesPresenterImpl(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
