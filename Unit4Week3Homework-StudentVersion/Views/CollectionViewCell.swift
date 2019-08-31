//
//  CollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    lazy var imageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    lazy var highLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = NSTextAlignment.center
        lab.text = "HighTemp: "
        return lab
    }()
    lazy var lowLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = NSTextAlignment.center
        lab.text = "LowTemp: "
        return lab
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
        setUpViews()
    }
    private func setUpViews() {
        setupDateLabel()
        setupImageView()
        setupHighLabel()
        setupLowLabel()
    }
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    private func setupHighLabel() {
        addSubview(highLabel)
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        highLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
    private func setupLowLabel() {
        addSubview(lowLabel)
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor).isActive = true
    }

}
