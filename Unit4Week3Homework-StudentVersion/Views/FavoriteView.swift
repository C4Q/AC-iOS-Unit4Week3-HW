//
//  FavoriteView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteView: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = bounds // bounds here is the MainView's bounds which is UIScreen.main.bounds
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        tv.rowHeight = 300
        return tv
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        
        return iv
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
        setupViews()
    }
    
    private func setupViews() {
        addSubview(tableView)
        //setupImageView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.contentMode = .scaleAspectFill
    }
   
}
