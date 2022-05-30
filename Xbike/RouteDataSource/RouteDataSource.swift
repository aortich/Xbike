//
//  RouteDataSource.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation

class RouteDataSource {
    static let shared = RouteDataSource()
    let cache: NSCache<NSString, NSArray>
    let modelKey: String = "routes"
    
    private init() {
        self.cache = NSCache<NSString, NSArray>()
    }
    
    func addRoute(route: RouteCell.ViewModel) {
        if var array = cache.object(forKey: modelKey as NSString) as? [RouteCell.ViewModel] {
            array.append(route)
            cache.setObject(array as NSArray, forKey: modelKey as NSString)
            return
        }
        
        cache.setObject([route], forKey: modelKey as NSString)
    }
    
    func retrieveRoutes() -> [RouteCell.ViewModel] {
        guard let array = cache.object(forKey: modelKey as NSString) as? [RouteCell.ViewModel] else {
            return []
        }
        return array
    }
}
