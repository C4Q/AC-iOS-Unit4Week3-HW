//
//  FavoriteViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "favoriteCell")
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FileManagerHelper.manager.loadFavoriteImagesFromDisk()
        tableView.reloadData()
    }
    
    private func commonInit() {
        addSubview()
        tableView.dataSource = self
    }
    
    func addSubview() {
        self.view.addSubview(tableView)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileManagerHelper.manager.getAllImages().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        let favoriteImage = FileManagerHelper.manager.getImageFromDisk(with: FileManagerHelper.manager.getAllImages()[indexPath.row].id)
        cell.favoriteImage.image = favoriteImage
        return cell
    }
}


