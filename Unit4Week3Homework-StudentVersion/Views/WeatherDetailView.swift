//
//  WeatherDetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import QuartzCore

class WeatherDetailView: UIView {
    
    var weatherOfTheDay: Weather!
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.darkGray
        label.text = "City Name"
        label.textDropShadow()
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var shortWeatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Condensed Ultra Light", size: 35)
        label.text = "Partly Cloudy"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textDropShadow()
        return label
    }()
    
    lazy var weatherStatusTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = UIFont(name: "Avenir Next", size: 18)
        textView.textDropShadow()
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
//                setUpCityLabelConstraints()
        setUpDetailImageViewConstraints()
        setUpShortWeatherDescriptionLabelConstraints()
                setUpWeatherStatusTextViewConstraints()
    }
    
    private func setupViews() {
        let weatherDetailedItems = [cityLabel, detailImageView, shortWeatherDescriptionLabel, weatherStatusTextView] as [UIView]
        weatherDetailedItems.forEach{ addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false }
        
//        let shadowForText = CALayer()
//        shadowForText.shadowOpacity = 1.0
//        shadowForText.shadowOffset = CGSize(width: 5, height: 4)
//        shadowForText.shadowColor = UIColor.white.cgColor
//        shadowForText.shadowRadius = 1.0
//        shadowForText.shouldRasterize = true
//
//
//        let weatherText = [cityLabel, shortWeatherDescriptionLabel]
//        weatherText.forEach{ $0.layer.addSublayer(shadowForText)}
//        weatherStatusTextView.layer.addSublayer(shadowForText)
        
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
        //change constraints
        NSLayoutConstraint.activate([
            detailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            detailImageView.topAnchor.constraint(equalTo: topAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailImageView.bottomAnchor.constraint(equalTo: shortWeatherDescriptionLabel.bottomAnchor)
            ])
        
    }
    
}

//To give text shadow
extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}

extension UITextView {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    static func createCustomUITextView() -> UITextView {
        let tv = UITextView()
        tv.textDropShadow()
        return tv
    }
}
