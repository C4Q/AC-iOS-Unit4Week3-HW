//
//  FavoriteCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    func configureCell(_ cell: FavoriteCell, index: IndexPath) -> FavoriteCell {
        let index = index.row
        let imageName = KeyedArchiverClient.shared.fetchListOfImages()[index]
        favImageView.image = KeyedArchiverClient.shared.getImageFromDisk(artworkPath: imageName)
        return cell
    }

    lazy var favImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        setupViews()
    }
    
    func setupViews() {
        self.selectionStyle = .none
        setupFavImageView()
    }

    func setupFavImageView() {
        addSubview(favImageView)
        favImageView.translatesAutoresizingMaskIntoConstraints = false
        favImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        favImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        favImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        favImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        favImageView.bounds = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height / 2)
    }
}
