//
//  FavoritesTableViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    lazy var favoritesImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FavoritesTableViewCell")
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.purple
        setUpFavoriteImageViews()
        
    }
    
    private func setUpFavoriteImageViews() {
        favoritesImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            favoritesImageView.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
            ])
     
    }

}
