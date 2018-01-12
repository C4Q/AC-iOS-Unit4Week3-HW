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
    var cityName = ""
    var favoriteImage: FavoriteImage!
    
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
    
    lazy var imageViewStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 4.0
        return stView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Forecast"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "download"), style: .plain, target: self, action: #selector(saveToFavorite))
        setupLabels()
        view.backgroundColor = .white
        loadImage()
    }
    
    private func loadImage() {
        if let zipcode = UserDefaultsHelper.manager.getLastSearch() {
            let complationCityName: (String) -> Void = {(cityName) in
                self.favoriteImage = FavoriteImage(title: cityName, url: "")
                self.cityName = cityName
                self.cityName = cityName.replacingOccurrences(of: " ", with: "+")
                let complationImageURL: (Picture) -> Void = { (onlineImage) in
                    self.favoriteImage.url = onlineImage.imageURL
                    if let cacheImage = NSCacheHelper.manager.getImage(with: onlineImage.imageURL) {
                        self.weatherImageView.image = cacheImage
                        return
                    }
                    WeatherAPIClient.manager.getImage(from: onlineImage.imageURL, completionHandler: {self.weatherImageView.image = $0
                        self.weatherImageView.setNeedsLayout()
                    }, errorHandler: {print($0)})
                }
                WeatherAPIClient.manager.getPicture(cityName: self.cityName, completionHandler: complationImageURL, errorHandler: {print($0)})
            }
            
            ZipCodeHelper.manager.getLocationName(from: zipcode, completionHandler: complationCityName, errorHandler: {print($0)})
        }
    }
    
    @objc func saveToFavorite() {
        FileManagerHelper.manager.addNew(newFavoriteImage: self.favoriteImage)
        if let image = weatherImageView.image {
            FileManagerHelper.manager.saveImage(with: self.favoriteImage.url, image: image)
        }
        let message = "Image Saved to Favorites"
        let avc = UIAlertController(title: "Saved", message: message, preferredStyle: .alert)
        
        let okButton: (UIAlertAction) -> Void = { (alert) in
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.weatherImageView.layer.shadowOpacity = 5.0
            self.weatherImageView.layer.shadowOpacity = 5.0
        }
        avc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: okButton))
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
    
    private func fnCityName() {
        if let zipCode = UserDefaultsHelper.manager.getLastSearch() {
            let date = getDateFormatted(from: weather.dateTimeISO, format: "MMM d, yyyy")
            ZipCodeHelper.manager.getLocationName(from: zipCode, completionHandler: {self.nameCityLabel.text = "Weather forecast for \($0) for \(date)"}, errorHandler: {print($0)})
        }
    }
    
    private func addSubViews() {
        self.view.addSubview(headerStackView)
        self.view.addSubview(imageViewStackView)
        imageViewStackView.addArrangedSubview(weatherImageView)
        self.view.addSubview(weatherLabel)
        self.view.addSubview(detailStackView)
    }
    
    private func displaySubViews() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        imageViewStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func subviewsConstraints() {
        headerStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        headerStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        headerStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        imageViewStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor).isActive = true
        imageViewStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageViewStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45).isActive = true
        imageViewStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        weatherLabel.topAnchor.constraint(equalTo: imageViewStackView.bottomAnchor, constant: 5).isActive = true
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


// MARK:- Functions 
extension WeatherDetailViewController {
    func getDateFormatted(from isoDate: String, format: String) -> String {
        let fromISODate = ISO8601DateFormatter()
        let getStrDateFormatted = DateFormatter()
        getStrDateFormatted.dateFormat = format
        if let dateFromISODate = fromISODate.date(from: isoDate) {
            var stringFromDate = getStrDateFormatted.string(from: dateFromISODate)
            if stringFromDate == getStrDateFormatted.string(from: Date()) && format == "EEEE, d" {
                stringFromDate = "Today"
            }
            return stringFromDate
        }
        return "N/A"
    }
}
