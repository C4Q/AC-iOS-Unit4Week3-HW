//
//  FavoritesView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesView: UIView {
    //TODO implement self sizing images
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(CityImageTableViewCell.self, forCellReuseIdentifier: "CityImageCell")
        tv.backgroundColor = .clear
        return tv
    }()
    
    //Initialization
    override init(frame: CGRect) {//overriding the parent class's functions
        super.init(frame: UIScreen.main.bounds)
        setUpGUI()
    }
    
    required init?(coder aDecoder: NSCoder) { //now the new initializer required for this uiView
        super.init(coder: aDecoder)
        //setUpGUI()
    }
    
    private func setUpGUI() {
        //backgroundColor = .white
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects() {
        
        //ARRAY MUST BE ON ORDER!!
        let favoriteObjects = [tableView] as [UIView]
        
        favoriteObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            ])
    }
}
