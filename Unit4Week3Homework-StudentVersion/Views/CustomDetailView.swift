//
//  CustomDetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class CustomDetailView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "Weather forcast for Chicogo for date "
        return label
    }()
    lazy var imageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "MostCloudy"
        return label
    }()
    lazy var highLabel: UILabel = {
       let label = UILabel()
      label.textAlignment = NSTextAlignment.left
        label.text = "High: "
      return label
    }()
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.text = "Low: "
        return label
    }()
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.text = "Sunrise: "
        return label
    }()
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.text = "Sunset: "
        return label
    }()
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.text = "Windspeed: "
        return label
    }()
    lazy var precLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.text = "Inches of Precipitation: "
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
        setUpViews()
    }
    private func setUpViews() {
        setupTitleLabel()
        setupImageView()
        setupInfoLabel()
        setupHighLabel()
         setupLowLabel()
        setupSunriseLabel()
        setupSunsetLabel()
        setupWindtLabel()
        setupPrectLabel()
    }
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
  
    private func setupInfoLabel() {
        addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
       // infoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    private func setupHighLabel() {
        addSubview(highLabel)
       highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        highLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5).isActive = true
    //   highLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    private func setupLowLabel() {
        addSubview(lowLabel)
          lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor).isActive = true
       //  lowLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    private func setupSunriseLabel() {
        addSubview(sunriseLabel)
          sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        sunriseLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor).isActive = true
        // sunriseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    private func setupSunsetLabel() {
        addSubview(sunsetLabel)
       sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor).isActive = true
     //  sunsetLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    private func setupWindtLabel() {
        addSubview(windLabel)
       windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        windLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor).isActive = true
    // windLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    private func setupPrectLabel() {
        addSubview(precLabel)
      precLabel.translatesAutoresizingMaskIntoConstraints = false
        precLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        precLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor).isActive = true
       // windLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
}
