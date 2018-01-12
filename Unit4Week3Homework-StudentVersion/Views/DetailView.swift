//
//  DetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit



class DetailView: UIView {

    lazy var cityAndDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Weather forcast in New York on date.."
        return label
    }()
    
    lazy var cityImage: UIImageView = {
        let image =  UIImageView()
        image.backgroundColor = .red
        return image
    }()
    
    lazy var primaryWeatherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .gray
        label.text = "Cloudy"
        return label
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: createLabel(named: "High: °F", "Low: °F", "Sunrise:", "Sunset:", "Windspeed:", "Inches of Percipiation:"))
    
    private func createLabel(named: String...) -> [UILabel] {
        return named.map { name in
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = UIColor(displayP3Red: 0, green: 1, blue: 1, alpha: 1)
            label.text = name
            return label
        }
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
        setupCityAndDate()
        setupImageView()
        setupPrimaryWeatherLabel()
        setupStackView()
       
        

    }

    func setupCityAndDate() {
        addSubview(cityAndDateLabel)
        cityAndDateLabel.translatesAutoresizingMaskIntoConstraints = false
        cityAndDateLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityAndDateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.topAnchor.constraint(equalTo: primaryWeatherLabel.bottomAnchor, constant: 5)
        stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    func setupPrimaryWeatherLabel() {
        addSubview(primaryWeatherLabel)
        primaryWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryWeatherLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        primaryWeatherLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 20).isActive = true
//        primaryWeatherLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 20).isActive = true
    }
    
    func setupImageView() {
        addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        cityImage.topAnchor.constraint(equalTo: cityAndDateLabel.bottomAnchor, constant: 20).isActive = true
        //        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cityImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cityImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        cityImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }

    func configureView(forecast: WeatherInfo, cityName: String) {
        let dateFromISO = ISO8601DateFormatter()
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "MMM d, yyyy" //Jan 5, 2018
        if let ISODate = dateFromISO.date(from: forecast.validTime) {
            let strDateFormatted = dateFormatted.string(from: ISODate)
            cityAndDateLabel.text = "Weather forecast for \(cityName) on \(strDateFormatted)"
        }
        
        var city = cityName
        city = city.replacingOccurrences(of: " ", with: "+")
        
        PixbayImageAPIClient.manager.getImages(named: city, completionHandler: {
            if let urlImage = $0.hits[0].webformatURL {
                GetImagesAPI.manager.getImage(from: urlImage, completionHandler: {self.cityImage.image = $0}, errorHandler: {print($0)})
            }
        }, errorHandler: {print($0)})
        
    }
    
    
   
}
