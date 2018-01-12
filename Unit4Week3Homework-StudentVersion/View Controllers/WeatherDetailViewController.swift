//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Forecast"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "download"), style: .plain, target: self, action: #selector(saveToFavorite))
        setupLabels()
        view.backgroundColor = .white
        loadImage()
    }
    
    var weather: Weather!
    var cityName = ""
    var favoriteImage: FavoriteImage!
    var centerImage = NSLayoutConstraint()
    var propertyAnimator = UIViewPropertyAnimator(duration: 5.0, curve: UIViewAnimationCurve.easeInOut, animations: nil)
    
    lazy var nameCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forecast for N/A"
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        label.textAlignment = .left
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var incPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var containerImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var headerStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 0.0
        return stView
    }()
    
    lazy var detailStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.leading
        stView.spacing   = 2.0
        return stView
    }()
    
    
    
    @objc func saveToFavorite() {
        FileManagerHelper.manager.addNew(newFavoriteImage: self.favoriteImage)
        if let image = weatherImageView.image {
            FileManagerHelper.manager.saveImage(with: self.favoriteImage.url, image: image)
        }
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.centerImage.constant = 400
        
        propertyAnimator.addAnimations {
            self.view.layoutIfNeeded()
            self.weatherImageView.layer.shadowOpacity = 1
            self.weatherImageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
            self.weatherImageView.layer.opacity = 0.0
        }
        propertyAnimator.startAnimation()
        
        let message = "Image Saved to Favorites"
        let avc = UIAlertController(title: "Saved", message: message, preferredStyle: .alert)
        avc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(avc, animated: true, completion: nil)
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
        fnCityName()
        self.weatherImageView.image = UIImage(named: weather.icon)
        self.weatherLabel.text = weather.weather
        self.highLabel.text = "High: \(weather.maxTempF)ºF"
        self.lowLabel.text = "Low: \(weather.minTempF)ºF"

        self.sunriseLabel.text = "Sunrise: " + getDateFormatted(from: weather.sunriseISO, format: "hh:mm:ss")
        self.sunsetLabel.text = "Sunset: " + getDateFormatted(from: weather.sunsetISO, format: "hh:mm:ss")
        self.windSpeedLabel.text = "Windspeed: \(weather.windSpeedMPH) MPH"
        self.incPrecipitationLabel.text = "Inches of Precipitation: \(weather.pressureIN)"
    }
    
    private func addSubViews() {
        self.view.addSubview(headerStackView)
        self.view.addSubview(weatherImageView)
        self.view.addSubview(weatherLabel)
        self.view.addSubview(detailStackView)
    }
    
    private func displaySubViews() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func subviewsConstraints() {
        headerStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        headerStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        headerStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        weatherImageView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45).isActive = true
        centerImage = weatherImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        centerImage.isActive = true

        weatherLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 5).isActive = true
        weatherLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        detailStackView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 8).isActive = true
        detailStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.55).isActive = true
        detailStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func addSubViewsDetailStackView() {
        headerStackView.addArrangedSubview(nameCityLabel)
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
