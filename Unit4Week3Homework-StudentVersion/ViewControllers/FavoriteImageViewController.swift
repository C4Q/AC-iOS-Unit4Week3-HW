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
        tableView.delegate = self
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
extension FavoriteImageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedImage = KeyedArchiverClient.shared.fetchListOfImages()[indexPath.row]
        deleteAlert(name: selectedImage)
        
    }
    func deleteAlert(name: String) {
        let alert = UIAlertController(title: nil, message: "Do you want to delete this Image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            KeyedArchiverClient.shared.deleteImage(artworkPath: name)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}


