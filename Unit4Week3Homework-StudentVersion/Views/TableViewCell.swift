//
//  TableViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/17/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    lazy var myImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "favoriteCell")
        commoninit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoninit()
    }
    private func commoninit() {
        setupView()
    }
    
    private func setupView() {
        setupImageView()
    }
    private func setupImageView() {
        addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
