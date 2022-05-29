//
//  AppDelegate.swift
//  Xbike
//
//  Created by Alberto Ortiz on 28/05/22.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("AIzaSyA03eC065OdSiWiQ8sx4xCHJkmWirEXyL8")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .orange
        window?.rootViewController = MapViewControllerImpl()
        
        
        return true
    }

}

