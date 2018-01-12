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
        imageView.contentMode = UIViewContentMode.scaleAspectFit
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
        backgroundColor = UIColor.gray
        setUpFavoriteImageViews()
        
    }
    
    private func setUpFavoriteImageViews() {
        contentView.addSubview(favoritesImageView)
        
        favoritesImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoritesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            favoritesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoritesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
     
    }

}
