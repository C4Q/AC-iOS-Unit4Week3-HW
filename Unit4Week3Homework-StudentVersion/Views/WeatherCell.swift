//
//  WeatherCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    lazy var weatherIcon: UIImageView = {
       let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Date().description
        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var lowLabel: UILabel = {
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
    }
    private func setupViews() {
        let viewItems = [dateLabel, highLabel, lowLabel, weatherIcon] as [UIView]
        viewItems.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false; ($0).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true}
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor),
            
            weatherIcon.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            
            highLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 20),
            
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 5)
            ])
    }
    func configureWeatherCell(weather: Weather) {
        
        dateLabel.text = Date.dateStringFromTimeInterval(timeinterval: TimeInterval(weather.timestamp))
        highLabel.text = "High: \(weather.maxTempF.description)\u{00B0}F"
        lowLabel.text = "Low: \(weather.minTempF.description)\u{00B0}F"
        weatherIcon.image = UIImage(named: weather.icon.replacingOccurrences(of: ".png", with: ""))
    }
}
