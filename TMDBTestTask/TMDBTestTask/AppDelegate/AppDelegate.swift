//
//  AppDelegate.swift
//  TMDBTestTask
//
//  Created by Maksym Vitovych on 20.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRootVC()
        // Override point for customization after application launch.
        return true
    }
    
    private func setupRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomePageViewController.builder.default()
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

