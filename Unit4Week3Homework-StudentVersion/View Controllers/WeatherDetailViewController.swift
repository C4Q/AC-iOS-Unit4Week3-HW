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
    var chosenCity: String!
    var image: UIImage!
    var pixabay: Hits!
    
    init(weather: DailyForecast, city: String, pixabay: Hits) {
        super.init(nibName: nil, bundle: nil)
        self.dayForecast = weather
        self.chosenCity = city
        self.pixabay = pixabay
        
        print("this is the weather in dvc\(weather)")
        weatherDetailView.configureDetailView(weatherInfo: weather, city: city, imageUrl: pixabay.webformatURL)
        ImageAPIClient.manager.getImage(from: pixabay.webformatURL, completionHandler: {self.image = $0; self.weatherDetailView.detailImageView.image = $0}, errorHandler: {print($0,"error getting image")})
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
        guard let image = self.weatherDetailView.detailImageView.image else {return}
        PersistentStoreManager.manager.addToFavorites(pixabay: pixabay, cityName: chosenCity, andImage: image)
        
        //ALERT AFTER CLICKING SAVE
        let alert = UIAlertController(title: "Save to Favorites", message: "Saved to Favorites", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}


