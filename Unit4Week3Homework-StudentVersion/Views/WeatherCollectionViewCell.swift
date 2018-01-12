//
//  WeatherCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(displayP3Red: 0, green: 1, blue: 1, alpha: 1)
//        label.backgroundColor = .green
        label.text = "Weather forcast for date()..."
        return label
    }()
    
    lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(displayP3Red: 0, green: 1, blue: 1, alpha: 1)
        label.text = "High: () degree"
        return label
    }()
    
    lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(displayP3Red: 0, green: 1, blue: 1, alpha: 1)
        label.text = "Low: () degree"
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
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
        setupDateLabel()
        setupImageView()
        setupMinTempLabel()
        setupMaxTempLabel()
        
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
//
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }

    private func setupMaxTempLabel() {
        addSubview(maxTempLabel)
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        maxTempLabel.bottomAnchor.constraint(equalTo: minTempLabel.topAnchor).isActive = true
        maxTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func setupMinTempLabel() {
        addSubview(minTempLabel)
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        minTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    
}
