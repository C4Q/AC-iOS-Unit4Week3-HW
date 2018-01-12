//
//  forecastDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForecastDetailViewController: UIViewController {

    
   
    var forecast: Forecast
    let detailView = DetailView()
    var citySearch = ""
    
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // scroll to top of text view
        let range = NSRangeFromString(detailView.detailTextView.text)
        detailView.detailTextView.scrollRangeToVisible(range)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaultHelper.manager.getZip() != nil{
            ZipCodeHelper.manager.getLocationName(from: UserDefaultHelper.manager.getZip()!, completionHandler: {self.citySearch = $0.replacingOccurrences(of: " ", with: "+")}, errorHandler: {print($0)})
        }else{
            ZipCodeHelper.manager.getLocationName(from: "11365", completionHandler: {self.citySearch = $0.replacingOccurrences(of: " ", with: "+")}, errorHandler: {print($0)})
        }
        view.backgroundColor = .clear
        view.addSubview(detailView)
        setDetails()
        // setup dismiss buttons
        detailView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        detailView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
   
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    
    init(forecast: Forecast) {
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setDetails(){
        
        
        if citySearch != "" {
       var urlStr = "https://pixabay.com/api/?key=7615649-d6a822b7c4e748f5a5b4e5b76&q=\(citySearch)&image_type=photo"
        
     
        
        }
        
        
        
        
        detailView.titleLabel.text =  Date.dateStringFromTimeInterval(timeinterval: TimeInterval(forecast.timestamp))
        detailView.detailTextView.textAlignment = .center
        let summary = forecast.weather
        detailView.detailTextView.text = """
        
        \(summary)
        
        High: \(forecast.maxTempF)°F
        
        Low: \(forecast.minTempF)°F
        
        Sunrise: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(forecast.sunrise)))
        
        Sunset: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(forecast.sunset)))
        
        Windspeed: \(forecast.windSpeedMPH) MPH
        
        Precipitation(Inches): \(forecast.precipIN)
        
        """
        
        
        
    }
    
    
    

}
