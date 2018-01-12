//
//  FavoriteImageViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteImageViewController: UIViewController {
    
    

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "DetailCell")
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}
extension FavoriteImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KeyedArchiverClient.shared.fetchListOfImages().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! FavoriteCell
        let image = KeyedArchiverClient.shared.getImage(artworkPath: KeyedArchiverClient.shared.fetchListOfImages()[indexPath.row])
        cell.CityImage.image = image
        return cell
    }
}


