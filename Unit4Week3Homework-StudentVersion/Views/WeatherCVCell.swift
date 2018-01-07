//
//  CollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCVCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.contentView.backgroundColor = .white
        setupCellConstrains()
    }
    
    private func setupCellConstrains() {
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(highLabel)
        self.contentView.addSubview(lowLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cellViewConstrains()
    }
    
    private func cellViewConstrains() {
        dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        weatherImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.66).isActive = true
        highLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor).isActive = true
        highLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor).isActive = true
        lowLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
}
