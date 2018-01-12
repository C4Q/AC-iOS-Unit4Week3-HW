//
//  WeatherCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sunnyw")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.text = "High: 40"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Low: BRICK!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupDateLabel()
        setupImageView()
        setupHighTempLabel()
        setupLowTempLabel()
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
             dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
             dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    private func setupImageView() {
        addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [weatherImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
             weatherImage.leadingAnchor.constraint(equalTo: leadingAnchor),
             weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    private func setupHighTempLabel() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [highTempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 15),
             highTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
             highTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    private func setupLowTempLabel() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor, constant: 10),
             lowTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
             lowTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
             /*lowTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor)*/])
    }
    
    
    
    
    
    
    
}
