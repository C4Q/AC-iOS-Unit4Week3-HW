//
//  ForecastCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
            ])
    }
    
    lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func setupConditionImageView() {
        addSubview(conditionImageView)
        
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conditionImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0),
            conditionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            conditionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            conditionImageView.heightAnchor.constraint(equalTo: widthAnchor)
            ])
    }
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private func setupHighLabel() {
        addSubview(highLabel)
        
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 5),
            highLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
            ])
    }
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private func setupLowLabel() {
        addSubview(lowLabel)
        
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 5),
            lowLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
            ])
        
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
        setupDateLabel()
        setupConditionImageView()
        setupHighLabel()
        setupLowLabel()
    }
    
}
