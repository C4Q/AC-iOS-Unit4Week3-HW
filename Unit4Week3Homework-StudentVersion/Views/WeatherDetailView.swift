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
        return imageView
    }()
    
    lazy var shortWeatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        label.text = "Partly Cloudy"
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherStatusTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.cyan
        textView.textAlignment = .center
        textView.text =
        """
        Hi. A lot of text goes here.
        Remember to make it 0 lines.
        Remember to make this uneditable/unselectable
        Bye.
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
        setUpCityLabelConstraints()
        setUpDetailImageViewConstraints()
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
    
    private func setUpDetailImageViewConstraints() {
        NSLayoutConstraint.activate([
            detailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -90),
            detailImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            detailImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
    
            
            ])
        
    }
    
    private func setUpShortWeatherDescriptionLabelConstraints() {
    NSLayoutConstraint.activate([
        shortWeatherDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        shortWeatherDescriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 45),
        shortWeatherDescriptionLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.06), shortWeatherDescriptionLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setUpWeatherStatusTextViewConstraints() {
        NSLayoutConstraint.activate([
            weatherStatusTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherStatusTextView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 155),
            weatherStatusTextView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            weatherStatusTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
            
            
            ])
        
    }
}
