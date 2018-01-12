//
//  FavoriteTableViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleToFill
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.layer.cornerRadius = 15
        view.layer.opacity = 5.0
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        addSubview(favoriteImageView)
        addSubview(messageView)
        messageView.addSubview(messageLabel)
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        //messageView.isHidden = false
        subViewConstraints()
        messageConstraints()
    }
    
    private func subViewConstraints() {
        favoriteImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        favoriteImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        favoriteImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: messageView.widthAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: messageView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor).isActive = true
    }
    
    func messageConstraints() {
        messageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        messageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20).isActive = true
        messageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
