//
//  WeatherCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
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
    }
    
    private func setupViews() {
        setupDateLabel()
        setupWeatherImageView()
        setupLowTempLabel()
        setupHighTempLabel()
    }
    
    //UIElements
    lazy var dateLabel: UILabel = {
       let dateLabel = UILabel()
        dateLabel.backgroundColor = .green
        dateLabel.textAlignment = .center
        dateLabel.text = "Date"
        return dateLabel
    }()
    
    lazy var weatherImageView: UIImageView = {
       let weatherImageView = UIImageView()
        weatherImageView.image = #imageLiteral(resourceName: "clear")
        weatherImageView.contentMode = .scaleAspectFit
        return weatherImageView
    }()
    
    lazy var highTempLabel: UILabel = {
        let highTempLabel = UILabel()
        highTempLabel.backgroundColor = .green
        highTempLabel.textAlignment = .center
        highTempLabel.text = "highTempLabel"
        return highTempLabel
    }()
    
    lazy var lowTempLabel: UILabel = {
        let lowTempLabel = UILabel()
        lowTempLabel.backgroundColor = .green
        lowTempLabel.textAlignment = .center
        lowTempLabel.text = "lowTempLabel"
        return lowTempLabel
    }()
 
    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        dateLabelConstraints.forEach{$0.isActive = true}
    }
    
    func setupWeatherImageView() {
        addSubview(weatherImageView)
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        let weatherImageViewConstraints = [
            weatherImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor),
            weatherImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        weatherImageViewConstraints.forEach{$0.isActive = true}
    }
    
    func setupHighTempLabel() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        let highTempLabelConstraints = [
            highTempLabel.bottomAnchor.constraint(equalTo: lowTempLabel.topAnchor),
            highTempLabel.widthAnchor.constraint(equalTo: widthAnchor),
            highTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        highTempLabelConstraints.forEach{$0.isActive = true}
    }
    
    func setupLowTempLabel() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        let lowTempLabelConstraints = [
            lowTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            lowTempLabel.widthAnchor.constraint(equalTo: widthAnchor),
            lowTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        lowTempLabelConstraints.forEach{$0.isActive = true}
    }
    
    public func configureCell(weatherData: Weather) {
        commonInit()
    }
}
