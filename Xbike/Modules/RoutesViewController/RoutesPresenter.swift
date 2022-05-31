//
//  RoutesPresenter.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation

public class RoutesPresenterImpl: RoutesPresenter {
    let view: RoutesViewControllerImpl
    let dataSource: RouteDataSource
    
    init(view: RoutesViewControllerImpl, service: RouteDataSource = RouteDefaultsDataSource()) {
        self.view = view
        self.dataSource = service
    }
    
    func getItemCount() -> Int {
        return self.dataSource.retrieveRoutes().count
    }
    
    func getItemAt(_ index: Int) -> RouteCell.ViewModel {
        let array = self.dataSource.retrieveRoutes()
            .map{ RouteCell.ViewModel(time: $0.time, distance: $0.distance) }
        if index >= array.count { return RouteCell.ViewModel(time: "", distance: "") }
        return array[index]
    }
}
