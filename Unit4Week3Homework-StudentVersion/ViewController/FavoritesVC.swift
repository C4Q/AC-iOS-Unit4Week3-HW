//
//  FavoritesVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    // MARK: - Properties
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addNavBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        print(KeyedArchiverClient.shared.fetchListOfImages())
    }
    
    // MARK: - Layout
    private func setupViews() {
        setupTableView()
    }
    
    private func addNavBar() {
        navigationItem.title = "Favorites"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButtonPressed))
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupCityNameLabel(_ label: UILabel, superView: UIView) {
        superView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
    // MARK: - Setup - View/Data
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
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
    
    // MARK: - User Actions
    @objc func clearButtonPressed() {
        clearFileManager()
    }
    
    func clearFileManager() {
        KeyedArchiverClient.shared.clearFavorites()
        tableView.reloadData()
    }
    
    func presentAnimatedCityLabel(name: String, to superView: UIView) {
        let label = createNameLabel
        let cityLabelNotSetUp = !label.isDescendant(of: superView)

        if cityLabelNotSetUp { setupCityNameLabel(label, superView: superView) }
        
        let addedView = superView.subviews.last! as! UILabel
        addedView.text = name
        performAnimations(on: addedView)
    }

    func performAnimations(on view: UILabel) {
       fadeOutNameLabel(view)
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
    
}

// MARK: Table View Data Source
extension FavoritesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favoritedImages = KeyedArchiverClient.shared.fetchListOfImages()
        return favoritedImages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let favoritedImages = KeyedArchiverClient.shared.fetchListOfImages()
        if favoritedImages.isEmpty {
            tableView.backgroundView = backgroundView
            return 0
        } else {
            tableView.backgroundView = nil
            return 1
        }
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        return cell.configureCell(cell, index: indexPath)
    }
    
}

// MARK: Table View Delegate
extension FavoritesVC: UITableViewDelegate {
    
    // MARK: Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        tableViewCellSelected(cell: cell, index: indexPath)
    }
    
    func tableViewCellSelected(cell: UITableViewCell, index: IndexPath) {
        let allImages = KeyedArchiverClient.shared.fetchListOfImages()
        let selectedImage = allImages[index.row]
        let cityName = selectedImage.components(separatedBy: ".").last!
        presentAnimatedCityLabel(name: cityName, to: cell)
    }
    
}
