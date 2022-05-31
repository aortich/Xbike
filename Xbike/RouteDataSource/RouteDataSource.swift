//
//  RouteDataSource.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation

class RouteDataSource {
    static let shared = RouteDataSource()
    let modelKey: String = "routes"
    let defaults: UserDefaults
    
    private init() {
        defaults = UserDefaults.standard
    }
    
    func addRoute(route: Route) {
        if let json = defaults.string(forKey: modelKey),
           let data = json.data(using: .utf8),
           var routes = try? JSONDecoder().decode(Routes.self, from: data).routes {
            routes.append(route)
            defaults.set(convertArrayToString(Routes(routes: routes)), forKey: modelKey)
            return
            
        }
        defaults.set(convertArrayToString(Routes(routes: [route])), forKey: modelKey)
    }
    
    func retrieveRoutes() -> [Route] {
        guard let json = defaults.string(forKey: modelKey),
              let data = json.data(using: .utf8),
              let array = try? JSONDecoder().decode(Routes.self, from: data) else {
            return []
        }
        
        return array.routes
    }
    
    private func convertArrayToString(_ routes: Routes) -> String {
        guard let data = try? JSONEncoder().encode(routes),
              let json = String(data: data, encoding: .utf8) else {
            return ""
        }
        
        return json
    }
}
