//
//  FavoriteCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    func setupCityImageView() {
        addSubview(cityImageView)
        
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: topAnchor),
            cityImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cityImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
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
        setupCityImageView()
    }
    
    
    
}
