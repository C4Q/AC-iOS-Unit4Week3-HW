//
//  DetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    ///Top of view
    lazy var cityDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var cityImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    /// labels: high, low, sunrise, sunset, windspeed and precipitation
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var windspeedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var precipitationLabel: UILabel = {
        let label = UILabel()
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
        backgroundColor = .white
        setupViews()
        setupTopConstraints()
        
    }
    private func setupViews() {
        ///Top View
        let topViewObjects = [cityDateLabel, cityImage, weatherDescriptionLabel] as [UIView]
        topViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false; ($0).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true}
        ///Labels
        let labelStackObjects = [highLabel, lowLabel, sunriseLabel, sunsetLabel, windspeedLabel, precipitationLabel]
        labelStackObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false; ($0).leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100).isActive = true}
    }
    private func setupTopConstraints() {
        NSLayoutConstraint.activate([
            cityDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cityDateLabel.widthAnchor.constraint(equalTo: widthAnchor),
            
            cityImage.topAnchor.constraint(equalTo: cityDateLabel.bottomAnchor, constant: 10),
            cityImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            cityImage.heightAnchor.constraint(equalTo: cityImage.widthAnchor),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 10),
            
            highLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 20),
            
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 10),
            
            sunriseLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 10),
            
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 10),
            
            windspeedLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 10),
            
            precipitationLabel.topAnchor.constraint(equalTo: windspeedLabel.bottomAnchor, constant: 10)
            
            ])
    }

}
