//
//  FavoriteViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    var favorites = [FavoriteImage]() {
        didSet {
            self.favoriteTableView.reloadData()
        }
    }
    
    lazy var favoriteTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.favoriteTableView)
        self.favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorite()
    }
    
    private func loadFavorite() {
        self.favorites = FileManagerHelper.manager.getAllFavoriteImages()
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //To Do:
        
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite = self.favorites[indexPath.row]
        let cell = FavoriteTableViewCell(style: .default, reuseIdentifier: "FavoriteCell")
        cell.messageLabel.text = favorite.title
        cell.messageLabel.backgroundColor = .red
        cell.favoriteImageView.image = nil
        cell.favoriteImageView.image = FileManagerHelper.manager.getImage(with: favorite.url)
        cell.favoriteImageView.setNeedsLayout()
        return cell
    }
}

// MARK:- Setting constraints
extension FavoriteViewController {
    func tableViewConstraints() {
        self.favoriteTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.favoriteTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.favoriteTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.favoriteTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
