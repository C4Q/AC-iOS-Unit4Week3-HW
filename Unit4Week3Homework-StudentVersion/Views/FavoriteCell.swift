//
//  DetailWeatherCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    lazy var CityImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        return image
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "DetailCell")
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
        contentView.addSubview(CityImage)
        CityImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            CityImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            CityImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            CityImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            CityImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
}
