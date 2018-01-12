//
//  WeatherCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    
    
   lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "testing"
        label.textAlignment = .center
        return label
    }()
    
    
   lazy var highLabel: UILabel = {
        let label = UILabel()
        label.text = "high"
    label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.text = "low"
        label.numberOfLines = 0

        label.textAlignment = .center
        return label
    }()
    
    
    lazy var forecastImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.image = #imageLiteral(resourceName: "sunny")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupTitle()
        setupForecastImage()
        setupHighLabel()
        setupLowLabel()
    }
    
    
    private func setupTitle(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.textAlignment = .center
    }
    
    
    private func setupForecastImage(){
        addSubview(forecastImage)
        forecastImage.translatesAutoresizingMaskIntoConstraints = false
        forecastImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 11).isActive = true
        forecastImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        forecastImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        forecastImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    }
    
    private func setupHighLabel(){
        addSubview(highLabel)
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.topAnchor.constraint(equalTo: forecastImage.bottomAnchor, constant: 8).isActive = true
        highLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        highLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setupLowLabel(){
        addSubview(lowLabel)
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 2).isActive = true
        lowLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lowLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}



