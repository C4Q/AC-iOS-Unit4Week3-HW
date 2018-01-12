//
//  DetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds) //This tells the button to be the size of the screen
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"save"), for: .normal)
        return button
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"exit"), for: .normal)
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.text = "TopLabel"
        return label
    }()
    
    lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "noImg")
        return imageView
    }()
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.text = "WeatherLabel"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "highLabel"
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "lowLabel"
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "sunriseLabel"
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "sunsetLabel"
        return label
    }()
    
    lazy var windspeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "windspeedLabel"
        return label
    }()
    
    lazy var inchesOfPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "inchesLabel"
        return label
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
        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
        // To add round edges
        cityImageView.layer.cornerRadius = cityImageView.bounds.width / 6.0
        cityImageView.layer.borderWidth = 2.0
        cityImageView.layer.borderColor = UIColor.black.cgColor
        cityImageView.layer.masksToBounds = true
    }
    
    private func setupViews() {
        //Remember that you need to call EVERY FUNCTION that deals with setting up the view
        setupBlurEffectView()
        setupDismissView()
        setupAndConstrainObjects()
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupDismissView() {
        addSubview(dismissView)
    }
    
    
    private func setupAndConstrainObjects() {
        
        //ARRAY MUST BE ON ORDER!!
        let allDetailViewObjects = [containerView, saveButton, exitButton, topLabel, cityImageView, weatherLabel, highLabel, lowLabel, sunriseLabel, sunsetLabel, windspeedLabel, inchesOfPrecipitationLabel] as [UIView]
        
        allDetailViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //containerView
            containerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.90),
            containerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.80),
            
            //saveButton
            saveButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            saveButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.10),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor),
            
            //exitButton
            exitButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            exitButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            exitButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.10),
            exitButton.widthAnchor.constraint(equalTo: exitButton.heightAnchor),
            
            //topLabel
            topLabel.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 5),
            topLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.90),
            
            //cityImageView
            cityImageView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 15),
            cityImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            //cityImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            //cityImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cityImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.95),
            cityImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.40),
            
            //weatherLabel
            weatherLabel.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 20),
            weatherLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            weatherLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.80),
            
            //highLabel
            highLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 20),
            highLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            highLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.80),
            
            //lowLabel
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 5),
            lowLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lowLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.80),
            
            //sunriseLabel
            sunriseLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 5),
            sunriseLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            sunriseLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.80),
            
            //sunsetLabel
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 5),
            sunsetLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            sunsetLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.80),
            
            //windspeedLabel
            windspeedLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 5),
            windspeedLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            windspeedLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.80),
            
            //inchesOfPrecipitationLabel
            inchesOfPrecipitationLabel.topAnchor.constraint(equalTo: windspeedLabel.bottomAnchor, constant: 5),
            inchesOfPrecipitationLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            inchesOfPrecipitationLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.80)
            
            ])
    }

    //MARK: - ConfigureCell for Detail View Controller
    public func configureDetailView(forecast: SevenDayForecast, city: String) {
        topLabel.text = "\(city)'s forecast for \(Date.dateStringFromTimeInterval(timeinterval: forecast.timeStamp))"
        weatherLabel.text = forecast.weatherConditions
        highLabel.text = "High: \(forecast.highTempF)°F"
        lowLabel.text = "Low: \(forecast.lowTempF)°F"
        sunriseLabel.text = "Sunrise: \(Date.timeStringFromTimeInterval(timeinterval: forecast.sunrise))"
        sunsetLabel.text = "Sunset: \(Date.timeStringFromTimeInterval(timeinterval: forecast.sunset))"
        windspeedLabel.text = " Wind Speed: \(forecast.windSpeedMPH) MPH"
        inchesOfPrecipitationLabel.text = "Rain Precipitation: \(forecast.rainPrecipIN)"
        //cityImageView.image = UIImage(named: "\(forecast.weatherIcon)")
    }
}

