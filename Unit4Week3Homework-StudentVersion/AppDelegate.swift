//
//  AppDelegate.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tbc = UITabBarController()
        
        //creating tab one: WeatherVC
        let weatherVC = WeatherViewController()
        weatherVC.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(named: "weatherTabBarItem"), tag: 0)
        
        //creating tab two: FavoritesVC
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "star"), tag: 1)
        
        //embedding nav controller with weather VC but not favorites VC
        let navController = UINavigationController(rootViewController: weatherVC)
        tbc.viewControllers = [navController,favoritesVC]
        //controllers.map {UINavigationController(rootViewController: $0)}
        
        //embedded VC's inside a tbc WITHOUT any nav controllers
        //tbc.setViewControllers([weatherVC, favoritesVC], animated: true)
        
        
        //MARK: for other use: Create and set a UINavigationController for each viewController.
        
        /*let controllers = [weatherVC, favoritesVC]
         tabBarController.viewControllers = controllers
         
         tabBarController.viewControllers = controllers.map{ UINavigationController(rootViewController: $0)}*/
        
        //set window to be entire witdth of screen
        window = UIWindow(frame: UIScreen.main.bounds)
        //set window's rrot VC to myVC
        window?.rootViewController = tbc
        //make view visable on screen
        window?.makeKeyAndVisible()
        
        FileManagerHelper.manager.loadFavoritesFromSandBox()
        FileManagerHelper.manager.loadFavorites()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

