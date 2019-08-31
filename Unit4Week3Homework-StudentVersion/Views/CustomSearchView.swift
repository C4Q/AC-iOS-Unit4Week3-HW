//
//  CustomSearchView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class CustomSearchView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "Weather forcast for "
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return cv
    }()
    lazy var textField: UITextField = {
       let tf = UITextField()
        tf.backgroundColor = UIColor.lightGray
        return tf
    }()
    lazy var instuctionLabel: UILabel = {
        let label = UILabel()
        label.text = "enter zip code"
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
        backgroundColor = .white
        setUpViews()
    }
    private func setUpViews() {
        setupTitleLabel()
        setupCollectionView()
        setupTextField()
        setupInstuctionLabel()
    }
   private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    private func setupTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    }
    private func setupInstuctionLabel() {
        addSubview(instuctionLabel)
        instuctionLabel.translatesAutoresizingMaskIntoConstraints = false
        instuctionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        instuctionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    

}
