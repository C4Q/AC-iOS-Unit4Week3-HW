//
//  WeatherDetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "TEST"
        
        return label
    }()
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
            ])
        
        
    }
    
    lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private func setupCityImageView() {
        addSubview(cityImageView)
        
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            cityImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            cityImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0)
            
            
            
            ])
        
    }
    
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"

        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"

        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"

        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"

        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"

        return label
    }()
    
    lazy var windspeedLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"

        return label
    }()
    
    lazy var percipitationLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"

        return label
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [conditionLabel, highLabel, lowLabel, sunriseLabel, sunsetLabel, windspeedLabel, percipitationLabel])
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.alignment = UIStackViewAlignment.center
        
        stackView.spacing = 3.0
        
        return stackView
    }()
    
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
            ])
    }
    
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
        setupTitleLabel()
        setupCityImageView()
        setupStackView()
    }

}
