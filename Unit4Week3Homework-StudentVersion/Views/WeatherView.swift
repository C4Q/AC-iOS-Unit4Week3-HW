//
//  MainWeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {

    
    lazy var inputZipCode: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        tf.placeholder = "Zip Code"
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.numbersAndPunctuation
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextFieldViewMode.whileEditing;
        tf.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    lazy var cityLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    lazy var instructionLabel: UILabel = {
       let label = UILabel()
        label.text = "Enter a Zip Code"
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        return cv
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
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        let viewItems = [collectionView, cityLabel, instructionLabel, inputZipCode] as [UIView]
        viewItems.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5),
            
            inputZipCode.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputZipCode.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            inputZipCode.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            instructionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: inputZipCode.bottomAnchor, constant: 10)
            
            ])
    }
    
    var widthConstraint = NSLayoutConstraint()
    
    func animateLabel() {
        let animation = CABasicAnimation(keyPath: "labelPosition")
        let fromValue = CATransform3DMakeScale(1, 1, 0)
        let toValue = CATransform3DMakeScale(0, 50, 0)
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.5
//        weatherView.cityLabel.layer.add(animation, forKey: nil)
    }

}
