//
//  WeatherDetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {
    
    var weatherOfTheDay: Weather!
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.darkGray
        label.text = "City Name"
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = #imageLiteral(resourceName: "fantasy-2543658_1920")
        return imageView
    }()
    
    lazy var shortWeatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Condensed Ultra Light", size: 35)
        label.text = "Partly Cloudy"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var weatherStatusTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "Avenir Next", size: 18)
        textView.textAlignment = .left
        textView.text =
        """
        High: 60
        Low: 30
        Sunrise: 5:41 AM
        Sunset: 6: 22 PM
        Wind Speed: 0 MPH
        Precipitation: 0
        """
        //remember to make this uneditable/unselectable
        return textView
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
        backgroundColor = UIColor.brown
        setupViews()
        //        setUpCityLabelConstraints()
//        setUpDetailImageViewConstraints()
        setUpShortWeatherDescriptionLabelConstraints()
                setUpWeatherStatusTextViewConstraints()
    }
    
    private func setupViews() {
        let weatherDetailedItems = [cityLabel, detailImageView, shortWeatherDescriptionLabel, weatherStatusTextView] as [UIView]
        weatherDetailedItems.forEach{ addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false }
        
    }
    
    private func setUpCityLabelConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -225),
            cityLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.06),
            cityLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
            
            
            ])
        
    }
    private func setUpShortWeatherDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            shortWeatherDescriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            shortWeatherDescriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            shortWeatherDescriptionLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.06), shortWeatherDescriptionLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
            ])
    }
    
    private func setUpWeatherStatusTextViewConstraints() {
        NSLayoutConstraint.activate([
            weatherStatusTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            weatherStatusTextView.bottomAnchor.constraint(equalTo: shortWeatherDescriptionLabel.topAnchor),
            weatherStatusTextView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.27),
            weatherStatusTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
            
            
            ])
        
    }
    
    private func setUpDetailImageViewConstraints() {
        NSLayoutConstraint.activate([
            detailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -90),
            detailImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            detailImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
        
        
            ])
        
    }
    
}
