//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    let favoriteView = FavoriteView()
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        favoriteView.tableView.dataSource = self
        self.title = "Favorites"
        view.addSubview(favoriteView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteView.tableView.reloadData()
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersistentStoreManager.manager.getFavorites().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteView.tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let favorites = PersistentStoreManager.manager.getFavorites().reversed()[indexPath.row]
        cell.imageView?.image = favorites.image
        return cell
    }
}
