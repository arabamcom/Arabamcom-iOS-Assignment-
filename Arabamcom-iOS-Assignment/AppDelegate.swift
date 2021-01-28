//
//  AppDelegate.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let listTableVC = ListTableViewController()
        let navController = UINavigationController(rootViewController: listTableVC)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }
}

