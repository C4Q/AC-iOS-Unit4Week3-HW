//
//  TabBarController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherviewController = WeatherViewController()
        let favoriteViewController = FavoriteViewController()
        
        let navigationController = UINavigationController(rootViewController: weatherviewController)
        
        weatherviewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favoriteViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let viewControllerList = [navigationController, favoriteViewController]
        viewControllers = viewControllerList
    }
}

