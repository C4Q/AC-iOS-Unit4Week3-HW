//
//  FavoriteView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteView: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        setupTableView()
    }
    
    func fadeOutNameLabel(_ view: UIView) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        let customTimingFunction = CAMediaTimingFunction(controlPoints: 0.67, 0.46, 0.59, 0.93)
        opacityAnimation.timingFunction = customTimingFunction
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.duration = 1.5
        view.layer.add(opacityAnimation, forKey: nil)
    }
    
    func presentAnimatedCityLabel(name: String, to superView: UIView) {
        let label = createNameLabel
        let cityLabelNotSetUp = !label.isDescendant(of: superView)
        
        if cityLabelNotSetUp { setupCityNameLabel(label, superView: superView) }
        
        let addedView = superView.subviews.last! as! UILabel
        addedView.text = name
        performAnimations(on: addedView)
    }
    
    private func setupCityNameLabel(_ label: UILabel, superView: UIView) {
        superView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    func performAnimations(on view: UILabel) {
        fadeOutNameLabel(view)
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
//        tv.dataSource = self
//        tv.delegate = self
        tv.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        return tv
    }()
    
    lazy var backgroundView: UILabel = {
        let label = UILabel()
        label.center = tableView.center
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 32)
        label.text = "No favorites 😎"
        label.textAlignment = .center
        return label
    }()
    
    lazy var createNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 32)
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        label.layer.opacity = 0.0
        return label
    }()
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func tableViewCellSelected(cell: UITableViewCell, index: IndexPath) {
        let allImages = KeyedArchiverClient.shared.fetchListOfImages()
        let selectedImage = allImages[index.row]
        let cityName = selectedImage.components(separatedBy: ".").last!
        presentAnimatedCityLabel(name: cityName, to: cell)
    }
}
