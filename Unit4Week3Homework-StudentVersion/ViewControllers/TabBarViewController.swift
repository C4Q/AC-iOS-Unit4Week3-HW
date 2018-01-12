//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = MainViewController()
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondVC = FavoriteViewController()
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let tabBarList = [firstVC, secondVC]
        
        viewControllers = tabBarList
    }

    

}
