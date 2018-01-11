//
//  WeatherViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10/12/90"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.text = "90"
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
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
        let cellItems = [dateLabel, weatherImageView, highLabel, lowLabel] as [UIView]
        cellItems.forEach{ addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        setUpDateLabelConstraints()
        setUpImageViewConstraints()
        setUpHighLabelConstraints()
        setUpLowLabelConstraints()
    }
    
    private func setUpDateLabelConstraints() {
        NSLayoutConstraint.activate([dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor), dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
                                  dateLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9), dateLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)])
    }
    
    private func setUpImageViewConstraints() {
        NSLayoutConstraint.activate([
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor), weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10), weatherImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            weatherImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)])
    }
    
    private func setUpHighLabelConstraints() {
        NSLayoutConstraint.activate([highLabel.centerXAnchor.constraint(equalTo: centerXAnchor), highLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40), highLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8), highLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)])
        
    }
    
    private func setUpLowLabelConstraints() {
        NSLayoutConstraint.activate([lowLabel.centerXAnchor.constraint(equalTo: centerXAnchor), lowLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 60), lowLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8), lowLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)])
    }
}
