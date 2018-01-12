//
//  TabBarViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherVC = WeatherViewController()
        let favoritesVC = FavoritesViewController()
        let navController = UINavigationController(rootViewController: weatherVC)
        
        weatherVC.tabBarItem = UITabBarItem(title: "Weather", image: #imageLiteral(resourceName: "weather"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorites"), tag: 1)
        self.setViewControllers([navController, favoritesVC], animated: true)
        
        
    }

}
