//
//  TabBarController.swift
//  WeatherSample
//
//  Created by Simon Borkin on 6/12/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    func applyScreenLocalization() {
        guard let items = tabBar.items else { return }
        
        for (index, item) in items.enumerated() {
            var viewController = viewControllers?[index]
            
            if let navigationController = viewController as? UINavigationController {
                viewController = navigationController.topViewController
            }

            if viewController is HomeViewController {
                item.title = NSLocalizedString("home_title", comment: "")
            } else if viewController is ListViewController {
                item.title = NSLocalizedString("daily_title", comment: "")
            } else if viewController is AboutViewController {
                item.title = NSLocalizedString("about_title", comment: "")
            } else if viewController is SettingsViewController {
                item.title = NSLocalizedString("settings_title", comment: "")
            }
        }
    }
}

extension TabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyScreenLocalization()
        addObservers()
    }
    
    @objc func handleLanguageChanged() {
        applyScreenLocalization()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLanguageChanged),
                                               name: .userLanguageChanged,
                                               object: nil)
    }
}
