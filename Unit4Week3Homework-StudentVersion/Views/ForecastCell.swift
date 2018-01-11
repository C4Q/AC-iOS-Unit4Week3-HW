//
//  ForecastCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {

    
    //Date label
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textAlignment = .center //centers label
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    //Image
    
    lazy var weatherTypeImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    //High Temp Label
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.text = "High"
        label.textAlignment = .center //centers label
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    //Low Temp Label
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Low"
        label.textAlignment = .center //centers label
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) { // Required : Progamatic
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // Required : Storyboard
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        backgroundColor = .white
        setDateLabel()
        setUpImageConstraints()
        setUpHighTempLabel()
        setUpLowTempLabel()
    }
    
    
    override func layoutSubviews() {
        //we get the frame of the UI elements here
        weatherTypeImage.layer.cornerRadius = weatherTypeImage.bounds.width / 2.0 //making round
        weatherTypeImage.layer.masksToBounds = true //doesnt allow bleeding out of bounds
        weatherTypeImage.image = #imageLiteral(resourceName: "sunny")
        
    }
    
    //Set Up Date Label
    private func setDateLabel() {
        let sf = safeAreaLayoutGuide
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: sf.topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: sf.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: sf.trailingAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
    }
    
    //Set Up Image
    private func setUpImageConstraints() {
        addSubview(weatherTypeImage)
          let sf = safeAreaLayoutGuide
        weatherTypeImage.translatesAutoresizingMaskIntoConstraints = false
        weatherTypeImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        weatherTypeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        weatherTypeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8)
        weatherTypeImage.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
        weatherTypeImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    //Set up Hight Temp Label
    private func setUpHighTempLabel() {
        let sf = safeAreaLayoutGuide
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        highTempLabel.topAnchor.constraint(equalTo: weatherTypeImage.bottomAnchor, constant: 8).isActive = true
        highTempLabel.leadingAnchor.constraint(equalTo: sf.leadingAnchor).isActive = true
        highTempLabel.trailingAnchor.constraint(equalTo: sf.trailingAnchor).isActive = true
        highTempLabel.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
    }
    
    //Set Up Low Temp Label
    private func setUpLowTempLabel() {
        let sf = safeAreaLayoutGuide
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor).isActive = true
        lowTempLabel.leadingAnchor.constraint(equalTo: sf.leadingAnchor).isActive = true
        lowTempLabel.trailingAnchor.constraint(equalTo: sf.trailingAnchor).isActive = true
        lowTempLabel.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
    }
}
