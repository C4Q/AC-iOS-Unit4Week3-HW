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
        guard let date = DateManager.shared.convertDateToString(date: weatherData.validTime) else { return }
        self.dayLabel.text = date.day.uppercased()
        self.dateLabel.text = date.month + " " + date.numericalDay
        self.highTempLabel.text = "Max \(weatherData.maxTempF.description)F/\(weatherData.maxTempC.description)C"
        self.lowTempLabel.text = "Min \(weatherData.minTempF.description)F/\(weatherData.minTempC.description)C"
        self.imageView.image = UIImage(named: weatherData.icon)
    }
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 24)
        label.textColor = .white
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 18)
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
        setupDayLabel()
        setupDateLabel()
        setupImageView()
        setupHighTempLabel()
        setupLowTempLabel()
        
    }
    
    private func setupDayLabel() {
        addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
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
        lowTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
    }
    
}
