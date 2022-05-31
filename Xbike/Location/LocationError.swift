//
//  LocationError.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation

enum LocationError: Error {
    case disallowedLocation
}

extension LocationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .disallowedLocation:
            return NSLocalizedString("Permissions not granted, please grant permission", comment: "")
        }
    }
}
