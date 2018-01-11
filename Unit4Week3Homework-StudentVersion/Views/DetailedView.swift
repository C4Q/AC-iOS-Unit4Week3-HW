//
//  DetailedView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailedView: UIView {

    // TODO:
    //    Create Detailed View
    //    A Label naming the city and the forecast date
    //    A random image of the city
    //    A Label with a longer description of the weather
    //    Additional information about the weather including the high, low, sunrise, sunset, windspeed and precipitation
    //    Selecting the "Save" bar button item should save the image to your favorites and present an alert view informing the user.
    
    //Date label
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        label.textAlignment = .center //centers label
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    //Image
    
    lazy var weatherTypeImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.image = #imageLiteral(resourceName: "sunny")
        return imageview
    }()
    
    lazy var textScroll: UITextView = {
        let ts = UITextView()
        return ts
    }()
    
    lazy var saveButton: UIButton = {
        let sb = UIButton()
        sb.titleLabel?.text = "Save"
        return sb
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
        setUpSaveButton()
        setCityLabel()
        setUpImageConstraints()
        setUpTextScroll()
    }
 
    func setUpSaveButton() {
        let sf = safeAreaLayoutGuide
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: sf.topAnchor, constant: 8).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: sf.trailingAnchor, constant: 8).isActive = true
    }
    
    func setCityLabel() {
        let sf = safeAreaLayoutGuide
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: sf.trailingAnchor).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: sf.leadingAnchor).isActive = true
        
    }
    
    func setUpImageConstraints() {
        let sf = safeAreaLayoutGuide
        addSubview(weatherTypeImage)
        weatherTypeImage.translatesAutoresizingMaskIntoConstraints = false
        weatherTypeImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 16).isActive = true
        weatherTypeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        weatherTypeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true 
        weatherTypeImage.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
        weatherTypeImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setUpTextScroll() {
        let sf = safeAreaLayoutGuide
        addSubview(textScroll)
        textScroll.translatesAutoresizingMaskIntoConstraints = false
        textScroll.topAnchor.constraint(equalTo: weatherTypeImage.bottomAnchor).isActive = true
        textScroll.trailingAnchor.constraint(equalTo: sf.trailingAnchor).isActive = true
        textScroll.leadingAnchor.constraint(equalTo: sf.leadingAnchor).isActive = true
    }
    
    
}
