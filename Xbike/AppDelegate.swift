//
//  AppDelegate.swift
//  Xbike
//
//  Created by Alberto Ortiz on 28/05/22.
//

import UIKit
import MapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            return false
        }
        
        if appHasLaunched() {
            let navController = UINavigationController(rootViewController: TabController())
            self.navController = navController
        } else {
            let navController = UINavigationController(rootViewController: OnboardingController(transitionStyle: .scroll, navigationOrientation: .horizontal))
            self.navController = navController
        }
        
        window.makeKeyAndVisible()
        window.backgroundColor = .orange
        window.rootViewController = self.navController
        
        self.navController?.setNavigationBarHidden(true, animated: false)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.tabBarItemFont ?? UIFont.systemFont(ofSize: 14)], for: .normal)
        UITabBar.appearance().tintColor = .orange
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor : UIColor.white,
             NSAttributedString.Key.font : UIFont.navbarTitleFont ?? UIFont.systemFont(ofSize: 20)]
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    private func appHasLaunched() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "appHasLaunched"){
            return true
        }else{
            defaults.set(true, forKey: "appHasLaunched")
            return false
        }
    }
}

