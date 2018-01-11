//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.register(WeatherViewCell.self, forCellWithReuseIdentifier: "WeatherViewCell")
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        // layout.itemSize = view.bound.size
        return cv
    }()
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "New York"
        label.font = UIFont(name: "Avenir", size: 20)?.italic
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.numberOfLines = 0
        //        label.backgroundColor = UIColor.brown
   
        
        return label
        
    }()
    
    lazy var weatherTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Place Zip Code Here"
        textField.backgroundColor = UIColor.lightGray
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        return textField
    }()
    
    
 
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.black
        setupViews()
    }
    
    private func setupViews() {
        let weatherItems = [weatherTextField, cityNameLabel, weatherCollectionView] as [UIView]
        weatherItems.forEach{ addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false }
        setUpNameLabelConstraints()
        setUpCollectionViewConstraints()
        setUpWeatherTextField()
    }
    
    private func setUpNameLabelConstraints() {
        
        //Adds line under label
        let lineView = UIView(frame: CGRect(x: 0, y: cityNameLabel.frame.height + 28, width: frame.width, height: 1.0))
        lineView.backgroundColor = UIColor.lightGray
        cityNameLabel.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200),
            cityNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cityNameLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.06),
            cityNameLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            ])
    }
    
    private func setUpCollectionViewConstraints() {
        NSLayoutConstraint.activate([weatherCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     weatherCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -75),
                                     weatherCollectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
                                     weatherCollectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.99)
            
            ])
    }
    
    private func setUpWeatherTextField() {
        NSLayoutConstraint.activate([
            weatherTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 250),
            weatherTextField.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            weatherTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
            
            ])
        
    }
    
}
//Could not make font italic with name alone so needed to use extension to do so
extension UIFont {
    var bold: UIFont {
        return with(traits: .traitBold)
    } // bold
    
    var italic: UIFont {
        return with(traits: .traitItalic)
    } // italic
    
    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    } // boldItalic
    
    
    func with(traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        } // guard
        
        return UIFont(descriptor: descriptor, size: 0)
    } // with(traits:)
} // extension

