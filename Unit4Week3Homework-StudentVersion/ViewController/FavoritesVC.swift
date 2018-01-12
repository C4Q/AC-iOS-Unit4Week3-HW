//
//  FavoritesVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    // MARK: - Setup - View/Data
    let favoriteView = FavoriteView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupFavoriteView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteView.tableView.reloadData()
    }
    
    // MARK: - Layout
    func setupFavoriteView() {
        view.addSubview(favoriteView)
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self
    }
    
    private func setupNavBar() {
        navigationItem.title = "Favorites"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButtonPressed))
    }

    // MARK: - User Actions
    @objc func clearButtonPressed() {
        clearFileManager()
    }
    
    func clearFileManager() {
        KeyedArchiverClient.shared.clearFavorites()
        favoriteView.tableView.reloadData()
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
            favoriteView.tableView.backgroundView = favoriteView.backgroundView
            return 0
        } else {
            favoriteView.tableView.backgroundView = nil
            return 1
        }
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteView.tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        return cell.configureCell(cell, index: indexPath)
    }
    
}

// MARK: Table View Delegate
extension FavoritesVC: UITableViewDelegate {
    
    // MARK: Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = favoriteView.tableView.cellForRow(at: indexPath)!
        favoriteView.tableViewCellSelected(cell: cell, index: indexPath)
    }
    
}
