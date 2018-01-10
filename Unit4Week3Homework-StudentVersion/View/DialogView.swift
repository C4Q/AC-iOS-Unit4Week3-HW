//
//  DialogView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DialogView: UIView {
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 32)
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        label.layer.opacity = 1.0
        return label
    }()
    
    private func commonInit() {
        self.backgroundColor = .yellow
        setupViews()
    }
    
    private func setupViews() {
        setupCityNameLabel()
    }
    
    private func setupCityNameLabel() {
        self.addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cityNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
