//
//  DetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  let containerView = CustomDetailView()
    
    var weather: DayWeather?
    var city: String?
    var cities = [CityImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
     self.view.backgroundColor = .white
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveImage))
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.view.addSubview(containerView)
        setupContainerView()
        configureViews()
        
    }
    @objc func saveImage() {
    }
    func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true

        containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
           containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
    }
    func configureViews() {
        guard let city = city, let weather = weather else {return}
        let date = weather.validTime.components(separatedBy: "T")[0]
        self.containerView.titleLabel.text = "Weather forcast for \(city) for \(date) "
        let highTemp = weather.maxTempF
        let lowTemp = weather.minTempF
        let sunrise = weather.sunriseISO.components(separatedBy: "T")[1].components(separatedBy: "-")[0]
         let sunset = weather.sunsetISO.components(separatedBy: "T")[1].components(separatedBy: "-")[0]
        containerView.highLabel.text = "High: \(highTemp) ℉"
        containerView.lowLabel.text = "Low: \(lowTemp) ℉"
        containerView.sunriseLabel.text = "Sunrise: \(sunrise)"
        containerView.sunsetLabel.text = "Sunset: \(sunset)"
        let windSpeed = weather.windSpeed80mMPH
        containerView.windLabel.text = "Windspeed: \(windSpeed)"
        let precipitation = weather.precipIN
        containerView.precLabel.text = "Inches of Precipitation: \(precipitation)"
        containerView.infoLabel.text = weather.weather
      loadCityImage()
    }
    func loadCityImage() {
        guard let city = city else {return}
        print("~~~~~~~~~~~~~~~~")
        let completion: ([CityImage]) -> Void = {(onlineCities: [CityImage]) in
            let index = Int(arc4random_uniform(UInt32(onlineCities.count)))
            print("============================")
            print(index)
            let city = onlineCities[index]
            let urlStr = city.webformatURL
            print(urlStr)
            ImageAPIClient.manager.loadImage(from: urlStr, completionHandler: {self.containerView.imageView.image = $0}, errorHandler: {print($0)})
        }
        CityAPIClient.shared.getCityImages(from: city, completionHandler: completion, errorHandler: {print($0)})
    }

}
