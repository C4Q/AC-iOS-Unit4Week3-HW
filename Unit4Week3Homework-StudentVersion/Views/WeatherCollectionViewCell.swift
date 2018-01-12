//
//  WeatherCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    //dateLabel
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .center
        //label.text = "2017-01-09"
        return label
    }()
    
    //imageView
    lazy var weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //iv.image = #imageLiteral(resourceName: "sunnyw")
        return iv
    }()
    
    //highLabel
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 234/255, green: 171/255, blue: 0.23/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .center
        //label.text = "10 F"
        return label
    }()
    
    //lowLabel
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.backgroundColor = .clear
        label.textAlignment = .center
        //label.text = "5 F"
        return label
    }()
    
    
    //Initialization
    //This is boiler plate for UIView
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpGUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) { //now the new initializer required for this uiView
        super.init(coder: aDecoder)
        //setUpGUI()
    }
    
    //this gets called right away
    override func layoutSubviews(){
        super.layoutSubviews()
        //you get the frame of the UI Objects here
        weatherImage.layer.cornerRadius = weatherImage.bounds.width / 2.0
        weatherImage.layer.borderWidth = 1
        weatherImage.layer.borderColor = UIColor.white.cgColor
        weatherImage.layer.masksToBounds = true
    }
    
    private func setUpGUI() {
        //backgroundColor = .white
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        
        //ARRAY MUST BE ON ORDER!!
        let collectionViewObjects = [dateLabel, weatherImage, highLabel, lowLabel] as [UIView]
        
        collectionViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            //dateLabel
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            //WeatherImage
            weatherImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
            weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor),
            
            //highLabel
            highLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 7),
            highLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            //lowLabel
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 5),
            lowLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
    
    //MARK: - configure custom collection view cell
    public func configureCollectionViewCell(for forecast: SevenDayForecast){ //pass in forecast
        //setting properties for the custom collection view cell
        dateLabel.text = Date.dateStringFromTimeInterval(timeinterval: forecast.timeStamp) //need to filter out time
        highLabel.text = "\(forecast.highTempF)°F"
        lowLabel.text = "\(forecast.lowTempF)°F"
        weatherImage.image = (UIImage(named: forecast.weatherIcon))
    }
}
