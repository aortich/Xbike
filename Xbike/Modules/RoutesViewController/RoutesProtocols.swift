//
//  RoutesProtocols.swift
//  Xbike
//
//  Created by Alberto Ortiz on 31/05/22.
//

import Foundation

protocol RoutesPresenter {
    func getItemCount() -> Int
    func getItemAt(_ index: Int) -> RouteCell.ViewModel
}
