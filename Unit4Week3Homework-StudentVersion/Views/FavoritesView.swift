//
//  FavoritesView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    // Collection view
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteCell")
        collectionView.backgroundColor = .cyan
        
        return collectionView
    }()
    
    // Collection view constraints
    private func setupCollectionView() {
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
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
        setupCollectionView()
    }

}
