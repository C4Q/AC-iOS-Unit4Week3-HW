//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    let weatherDetailView = WeatherDetailView()
    
    private var dayForecast: DailyForecast!
    //TODO: Fix passed in city value
    var chosenCity: String!
    
    init(weather: DailyForecast, city: String) {
        super.init(nibName: nil, bundle: nil)
        self.dayForecast = weather
        self.chosenCity = city
        print("this is the weather in dvc\(weather)")
        weatherDetailView.configureDetailView(weatherInfo: weather, city: city)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) is not supported")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(weatherDetailView)
        configureNavBar()
        print("chosen city: \(chosenCity)")

    }
    
    private func configureNavBar() {
        navigationItem.title = "Forecast"
        let saveImageToFavoritesBarItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImageToFavorites))
        navigationItem.rightBarButtonItem = saveImageToFavoritesBarItem
    }
    
    @objc func saveImageToFavorites() {
        
    }
}


