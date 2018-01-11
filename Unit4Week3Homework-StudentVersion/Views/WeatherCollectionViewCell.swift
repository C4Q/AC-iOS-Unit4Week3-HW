//
//  WeatherCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2018-05-05"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var weatherGraphic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "rain")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.text = "High: 17 F"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Low: 17 F"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    // required. Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
//    convenience init(date: String,
//                     weatherGraphic: String,
//                     highTemp: Int,
//                     lowTemp: Int){
//        self.init(frame: UIScreen.main.bounds)
//        self.weatherGraphic.image = UIImage(named: weatherGraphic)
//        self.highTempLabel.text = "High: \(highTemp)°F"
//        self.lowTempLabel.text = "High: \(lowTemp)°F"
//        setupViews()
//    }
    
    //MARK: - Functions
    private func commonInit() {
        backgroundColor = .green
        setupViews()
    }
    
    private func setupViews() {
        setupDateLabel()
        setupWeatherGraphic()
        setupHighTempLabel()
        setupLowTempLabel()
        
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabel.centerXAnchor.constraintEqualToSystemSpacingAfter(centerXAnchor, multiplier: 0).isActive = true
    }
    
    private func setupWeatherGraphic() {
        addSubview(weatherGraphic)
        weatherGraphic.translatesAutoresizingMaskIntoConstraints = false
        weatherGraphic.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        weatherGraphic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        weatherGraphic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        weatherGraphic.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    private func setupHighTempLabel() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        highTempLabel.topAnchor.constraint(equalTo: weatherGraphic.bottomAnchor, constant: 20).isActive = true
        highTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }
    
    private func setupLowTempLabel() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor, constant: 5).isActive = true
        lowTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }

    public func configureCell(with weather: Details) {
        self.dateLabel.text = weather.dateTimeISO
        self.weatherGraphic.image = UIImage(named: "\(weather.icon)")
        self.highTempLabel.text = "High: \(weather.maxTempF)°F"
        self.lowTempLabel.text = "Low: \(weather.minTempF)°F"
    }
}
    //        self.dateLabel.text = weather.pe
    //        if let imageURL = fellow.imageURL {
    //            if let image = ImageCache.manager.cachedImage(url: imageURL) {
    //                profileImageView.image = image
    //            } else {
    //                ImageCache.manager.processImageInBackground(imageURL: imageURL, completion: { ( error, image) in
    //                    if let error = error {
    //                        print("fellowCell - error processing image: \(error.localizedDescription)")
    //                    } else if let image = image {
    //                        DispatchQueue.main.sync {
    //                            self.profileImageView.image = image
    //                        }
    //                    }
    //                })
    //            }
    //        } else {
    //            profileImageView.image = UIImage(named: "VRmLo5A")
    //        }
    //    }
    

