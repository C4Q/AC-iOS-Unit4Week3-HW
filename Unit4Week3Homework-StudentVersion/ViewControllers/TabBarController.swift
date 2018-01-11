//
//  TabBarViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        let navigation = UINavigationController(rootViewController: MainWeatherViewController())
        let favoriteVC = FavoriteImageViewController()
        navigation.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let tabList = [navigation, favoriteVC]
        viewControllers = tabList

    }

    

}
