//
//  TabBarController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let firstViewController = MainWeatherViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let secondViewController = FavoritesViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let viewControllerList = [firstViewController, secondViewController]
        self.viewControllers = viewControllerList.map {UINavigationController(rootViewController: $0)}
        //creates a nav controller for each vc amd returns that as an array to self.viewcontrollers
    }

   
}
