//
//  OnboardingController.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import UIKit

class OnboardingController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pages = [OnboardingSubscreenController]()
    let pageControl = UIPageControl()
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        let initialPage = 0
        let page1 = OnboardingSubscreenController()
        page1.updateImage(UIImage(named: "standing") ?? UIImage())
        page1.updateText("Extremely simple to use")
        
        let page2 = OnboardingSubscreenController()
        page2.updateImage(UIImage(named: "stopwatch") ?? UIImage())
        page2.updateText("Track your time and distance")
        
        let page3 = OnboardingSubscreenController()
        page3.updateImage(UIImage(named: "effort") ?? UIImage())
        page3.updateText("See your progress and challenge yourself!")
        
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        self.view.backgroundColor = .orange
        
        let pc = UIPageControl.appearance()
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .black
        pc.backgroundColor = .orange
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController as! OnboardingSubscreenController) {
                if viewControllerIndex == 0 {
                    return self.pages.last
                } else {
                    return self.pages[viewControllerIndex - 1]
                }
            }
            return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.firstIndex(of: viewController as! OnboardingSubscreenController) {
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            } else {
                goToRestOfApp()
                return self.pages.first
            }
        }
        return nil
    }
    
    func goToRestOfApp() {
        self.navigationController?.pushViewController(TabController(), animated: true)
    }
    
}
