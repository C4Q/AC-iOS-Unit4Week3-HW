//
//  WeatherDetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {
    //var thisCity: String!
    
    lazy var detailTitleLabel: UILabel = {
        let detailTitleLabel = UILabel()
        detailTitleLabel.textAlignment = .center
        detailTitleLabel.text = "title"
        return detailTitleLabel
    }()
    
    lazy var detailImageView: UIImageView = {
        let detailImageView = UIImageView()
        detailImageView.image = #imageLiteral(resourceName: "fair")
        detailImageView.contentMode = .scaleAspectFit
        return detailImageView
    }()
    
    lazy var weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.textAlignment = .center
        weatherLabel.text = "weather condition"
        return weatherLabel
    }()
    
    lazy var highTempLabel: UILabel = {
        let highTempLabel = UILabel()
        //highTempLabel.textAlignment = .center
        highTempLabel.text = "high temp"
        return highTempLabel
    }()
    
    lazy var lowTempLabel: UILabel = {
        let lowTempLabel = UILabel()
       // lowTempLabel.textAlignment = .center
        lowTempLabel.text = "low temp"
        return lowTempLabel
    }()
    
    lazy var sunriseLabel: UILabel = {
        let sunriseLabel = UILabel()
        //sunriseLabel.textAlignment = .center
        sunriseLabel.text = "sunrise"
        return sunriseLabel
    }()
    
    lazy var sunsetLabel: UILabel = {
        let sunsetLabel = UILabel()
        //sunsetLabel.textAlignment = .center
        sunsetLabel.text = "sunset"
        return sunsetLabel
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let windSpeedLabel = UILabel()
        //windSpeedLabel.textAlignment = .center
        windSpeedLabel.text = "wind speed"
        return windSpeedLabel
    }()
    
    lazy var precipitationLabel: UILabel = {
        let precipitationLabel = UILabel()
        //precipitationLabel.textAlignment = .center
        precipitationLabel.text = "precipitation"
        return precipitationLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        //print("this city set to \(thisCity)")
    }
    
    private func setupViews() {
        setupDetailTitleLabel()
        setupDetailImageView()
        setupWeatherLabel()
        setupHighTempLabel()
        setupLowTempLabel()
        setupSunriseLabel()
        setupSunsetLabel()
        setupWindSpeedLabel()
        setupPrecipLabel()
    }
    
    func setupDetailTitleLabel() {
        addSubview(detailTitleLabel)
        detailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
       detailTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        detailTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupDetailImageView() {
        addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 30).isActive = true
        detailImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        detailImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        detailImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupWeatherLabel() {
        addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 30).isActive = true
        weatherLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        weatherLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupHighTempLabel() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        highTempLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10).isActive = true
        highTempLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        highTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupLowTempLabel() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor, constant: 10).isActive = true
        lowTempLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        lowTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupSunriseLabel() {
        addSubview(sunriseLabel)
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.topAnchor.constraint(equalTo: lowTempLabel.bottomAnchor, constant: 10).isActive = true
        sunriseLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        sunriseLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupSunsetLabel() {
        addSubview(sunsetLabel)
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 10).isActive = true
        sunsetLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        sunsetLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupWindSpeedLabel() {
        addSubview(windSpeedLabel)
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 10).isActive = true
        windSpeedLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        windSpeedLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupPrecipLabel() {
        addSubview(precipitationLabel)
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 10).isActive = true
        precipitationLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        precipitationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    public func configureDetailView(weatherInfo: DailyForecast, city: String, imageUrl : String) {
        
        //TODO: Add images
        let date = weatherInfo.validTime
        let formattedDate = date.components(separatedBy: "T")
        let sunriseTime = weatherInfo.sunriseISO
        let formattedSunriseTime = sunriseTime.components(separatedBy: "T")
        let sunsetTime = weatherInfo.sunsetISO
        let formattedSunsetTime = sunsetTime.components(separatedBy: "T")
        detailTitleLabel.text = "Forecast for \(city) \(formattedDate[0])"
        weatherLabel.text = "\(weatherInfo.weather)"
        highTempLabel.text = "High Temp: \(weatherInfo.maxTempF)°F"
        lowTempLabel.text = "Low Temp: \(weatherInfo.minTempF)°F"
        sunriseLabel.text = "Sunrise: \(formattedSunriseTime[1])"
        sunsetLabel.text = "Sunset: \(formattedSunsetTime[1])"
        windSpeedLabel.text = "Windspeed: \(weatherInfo.windSpeedMPH)Mph"
        precipitationLabel.text = "Inches of Precipitation: \(weatherInfo.precipIN)"
        
        
        //detailImageView
        
    }
    
    
    
}
