//
//  DetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    // MARK: - Subviews
    lazy var cityImageView: UIImageView = {
        let iv = UIImageView()
        let activityIndicator = UIActivityIndicatorView.init(frame: iv.frame)
        activityIndicator.startAnimating()
        activityIndicator.center = iv.center
        self.addSubview(activityIndicator)
        activityIndicator.color = .green
        print(iv.subviews)
        return iv
    }()
    
    func configureLabels(weatherData: Period) {
        highLabel.text = weatherData.maxTempF.description
        lowLabel.text = weatherData.minTempF.description
        sunriseLabel.text = weatherData.sunrise.description
        sunsetLabel.text = weatherData.sunset.description
        windSpeedLabel.text = weatherData.windSpeed80mMPH.description
        precipLabel.text = weatherData.precipIN.description
    }
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        let text = ""
        label.text = text
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        let text = ""
        label.text = text
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        let text = ""
        label.text = text
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        let text = "Sunset: "
        label.text = text
        return label
    }()
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        let text = ""
        label.text = text
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        let text = ""
        label.text = text
        return label
    }()
    
    lazy var precipLabel: UILabel = {
        let label = UILabel()
        let text = ""
        label.text = text
        return label
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.activityIndicatorViewStyle = .whiteLarge
        ai.hidesWhenStopped = true
        ai.color = .orange
        ai.startAnimating()
        return ai
    }()
    
    lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 15
        
        stack.addArrangedSubview(highLabel)
        stack.addArrangedSubview(lowLabel)
        stack.addArrangedSubview(sunriseLabel)
        stack.addArrangedSubview(sunsetLabel)
        stack.addArrangedSubview(windSpeedLabel)
        stack.addArrangedSubview(precipLabel)
        
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - Setup
    func commonInit() {
        setupViews()
    }
    
    func setupViews() {
        setupCityImageView()
        setupStackView()
        setupAI()
    }
    
    private func setupCityImageView() {
        self.addSubview(cityImageView)
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        cityImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        cityImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 30).isActive = true
        cityImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cityImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        cityImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupStackView() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 100).isActive = true
    }
    
    func setupAI() {
        cityImageView.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: cityImageView.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor).isActive = true
    }
    
    
}
