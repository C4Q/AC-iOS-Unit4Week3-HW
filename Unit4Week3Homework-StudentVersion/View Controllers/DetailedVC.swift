//
//  DetailedVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {
    
    let detailView = DetailedView()
    var forecast: Forecast
    
    var weatherDetails: String = ""
    
    //Dependency Injection
    
    init(forecast: Forecast) {
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        view.addSubview(detailView)
           setUpWeatherDetails()
        if UserDefaultHelper.manager.getZip() != nil {
            ZipCodeHelper.manager.getLocationName(from: UserDefaultHelper.manager.getZip()!, completionHandler: {self.detailView.cityLabel.text = "Weather Forecast for " + $0 }, errorHandler: {print($0)})
        }
    }
    
    func setUpWeatherDetails() {
        
        detailView.cityLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)

        
        weatherDetails =
        """
        \(forecast.weather)
        High: \(forecast.maxTempF)
        Low: \(forecast.minTempF)
        Sunrise: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(forecast.sunrise)))
        Sunset: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(forecast.sunset)))
        Windspeed: \(forecast.windSpeedMPH)
        Precipitation: \(forecast.precipIN)
        """        
        detailView.textScroll.text = weatherDetails
        
        detailView.weatherTypeImage.image = UIImage(named: forecast.icon.replacingOccurrences(of: ".png", with: ""))

        
    }
    
    
    
    
    
    
}
