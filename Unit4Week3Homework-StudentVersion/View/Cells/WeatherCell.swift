//
//  WeatherCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    func configureCell(_ weatherData: Period) {
        self.dateLabel.text = DateManager.shared.convertDateToString(date: weatherData.validTime)
        self.highTempLabel.text = "Max Temp (F): " + weatherData.maxTempF.description
        self.lowTempLabel.text = "Min Temp (F): " + weatherData.minTempF.description
        self.imageView.image = UIImage(named: weatherData.icon)
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 24)
        label.textColor = .white
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 16)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Using coder init without the use of storyboards!")
    }
    
    func commonInit() {
        self.backgroundColor = UIColor(red:0.67, green:0.73, blue:0.80, alpha:0.20)
        self.layer.cornerRadius = 10.0
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
        dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setupHighTempLabel() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        highTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        highTempLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setupLowTempLabel() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor, constant: 20).isActive = true
        lowTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
}
