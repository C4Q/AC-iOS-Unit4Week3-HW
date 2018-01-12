//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //var sampleCityArray = [#imageLiteral(resourceName: "Chicago-IL"), #imageLiteral(resourceName: "Hastings"), #imageLiteral(resourceName: "phili"), #imageLiteral(resourceName: "tokyo")]
    
    let favoritesView = FavoritesView()
    let favoritesCustomCell = CityImageTableViewCell()
    
    var favoriteImages = [UIImage]() {
        didSet {
            favoritesView.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(favoritesView) //adding the custom view into the View Controller
        
        //TBV Delegates
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.estimatedRowHeight = 100
        favoritesView.tableView.rowHeight = UITableViewAutomaticDimension
        
        FileManagerHelper.manager.loadFavorites()
        self.favoriteImages = FileManagerHelper.manager.getFavoriteImagesFromFileManager()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityImageCell", for: indexPath) as! CityImageTableViewCell
        
        //cell.textLabel?.text = "Table Views... Good Stuff"
        
        let cityImage = favoriteImages[indexPath.row]
        
        cell.cityImageView.image = cityImage

        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    //TODO: -  when user taps on cell, name appears
    

  }





