//
//  ViewController.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/15.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .darkGray
        UINavigationBar.appearance().tintColor = .darkGray
        
        let searchVC = SearchController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let historyVC = HistoryController()
        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        let navigationC = [searchVC, historyVC].map { UINavigationController(rootViewController: $0)}
        
        setViewControllers(navigationC, animated: false)        
    }


}

