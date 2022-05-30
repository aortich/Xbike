//
//  TabController.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabMap = UINavigationController(rootViewController: MapViewControllerImpl())
        let tabMapItem = UITabBarItem(title: "Current Ride", image: nil, tag: 1)
        tabMap.tabBarItem = tabMapItem
        
        let tabRoutes = UINavigationController(rootViewController: RoutesViewControllerImpl())
        let tabRoutesItem = UITabBarItem(title: "My Progress", image: nil, tag: 2)
        tabRoutes.tabBarItem = tabRoutesItem
        
        self.viewControllers = [tabMap, tabRoutes]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected \(viewController.title)")
    }
}
