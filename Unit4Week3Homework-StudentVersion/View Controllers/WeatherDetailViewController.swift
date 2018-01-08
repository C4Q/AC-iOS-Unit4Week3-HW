//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var weather: Weather!
    
    lazy var nameCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forecast for N/A"
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var incPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var detailStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 4.0
        return stView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Forecast"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: #selector(saveToFavorite))
        setupLabels()
        view.backgroundColor = .white
    }
    
    @objc func saveToFavorite() {
        
    }
    
    private func setupLabels() {
        addSubViews()
        displaySubViews()
        subviewsConstraints()
        addSubViewsDetailStackView()
        displaySubViewsDetailStackView()
        filloutLabels()
    }
    
    private func filloutLabels() {
        cityName()
        self.weatherImageView.image = UIImage(named: weather.icon)
        self.weatherLabel.text = weather.weather
        self.highLabel.text = "High: \(weather.maxTempF)ºF"
        self.lowLabel.text = "Low: \(weather.minTempF)ºF"

        self.sunriseLabel.text = hourFromISODate(from: weather.sunriseISO, format: "hh:mm:ss")
        self.sunsetLabel.text = hourFromISODate(from: weather.sunsetISO, format: "hh:mm:ss")
        self.windSpeedLabel.text = "\(weather.windSpeedMPH) MPH"
        self.incPrecipitationLabel.text = "\(weather.pressureIN)"
    }
    
    private func cityName() {
        if let zipCode = UserDefaultsHelper.manager.getLastSearch() {
            let date = hourFromISODate(from: weather.dateTimeISO, format: "MMM d, yyyy")
            ZipCodeHelper.manager.getLocationName(from: zipCode, completionHandler: {self.nameCityLabel.text = "Weather forecast for \($0) for \(date)"}, errorHandler: {print($0)})
        }
    }
    
    private func hourFromISODate(from isoDate: String, format: String) -> String {
        let dateFormatterGet = ISO8601DateFormatter()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        if let date = dateFormatterGet.date(from: isoDate) {
            let stringFromDate = dateFormatterPrint.string(from: date)
            return stringFromDate
        }
        return "N/A"
    }
    
    private func addSubViews() {
        self.view.addSubview(nameCityLabel)
        self.view.addSubview(weatherImageView)
//        self.view.addSubview(detailStackView)
    }
    
    private func displaySubViews() {
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
//        detailStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func subviewsConstraints() {
        nameCityLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        nameCityLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        nameCityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        weatherImageView.topAnchor.constraint(equalTo: nameCityLabel.bottomAnchor, constant: 60).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.40).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

//        weatherLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8).isActive = true
//        weatherLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
//        weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//
//        detailStackView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 8).isActive = true
//        detailStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
//        detailStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func addSubViewsDetailStackView() {
        detailStackView.addArrangedSubview(highLabel)
        detailStackView.addArrangedSubview(lowLabel)
        detailStackView.addArrangedSubview(sunriseLabel)
        detailStackView.addArrangedSubview(sunsetLabel)
        detailStackView.addArrangedSubview(windSpeedLabel)
        detailStackView.addArrangedSubview(incPrecipitationLabel)
    }
    
    private func displaySubViewsDetailStackView() {
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        incPrecipitationLabel.translatesAutoresizingMaskIntoConstraints = false
    }

}
