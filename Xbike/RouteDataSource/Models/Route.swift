//
//  Route.swift
//  Xbike
//
//  Created by Alberto Ortiz on 31/05/22.
//

import Foundation

public struct Routes: Codable {
    let routes: [Route]
}
public struct Route: Codable {
    let time: String
    let distance: String
    
    
    enum CodingKeys: String, CodingKey {
        case time
        case distance
    }
}
