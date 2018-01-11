//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var weatherObject: Weather!
    var cityName: String!
    
    let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        constraintView()
        setView()
    }
    
    func setView() {
        
        guard let cityName = cityName else {return}
        detailView.cityDateLabel.text = "\(cityName) for \(Date.dateStringFromTimeInterval(timeinterval: TimeInterval(weatherObject.timestamp))) "
        
        //TODO: Image
        
        detailView.weatherDescriptionLabel.text = weatherObject.weather
        detailView.highLabel.text = "High: \(weatherObject.maxTempF)\u{00B0}F"
        detailView.lowLabel.text = "Low: \(weatherObject.minTempF)\u{00B0}F"
        detailView.sunriseLabel.text = "Sunrise: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(weatherObject.sunrise)))"
        detailView.sunsetLabel.text = "Sunset: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(weatherObject.sunset)))"
        detailView.windspeedLabel.text = "Windspeed: \(weatherObject.windSpeedMPH) MPH"
        detailView.precipitationLabel.text = "Precipitation: \(weatherObject.precipIN)"
    }
    
    func constraintView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
    }


}

