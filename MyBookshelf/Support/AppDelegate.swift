//
//  AppDelegate.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: Components
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init()
        window?.bounds = UIScreen.main.bounds
        window?.rootViewController = UINavigationController(rootViewController: SearchController())
        window?.makeKeyAndVisible()
        return true
    }
}

