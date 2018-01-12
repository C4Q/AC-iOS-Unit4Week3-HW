//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController{
    
    var sampleCityArray = [#imageLiteral(resourceName: "Chicago-IL"), #imageLiteral(resourceName: "Hastings"), #imageLiteral(resourceName: "phili"), #imageLiteral(resourceName: "tokyo")] //testing ONLY
    
    let favoritesView = FavoritesView()
    let weatherVC = WeatherViewController()
    let customTBV = CityImageTableViewCell()
    
    var favoriteImages = [UIImage]() {
        didSet {
            favoritesView.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favoritesView) //adding the custom view into the View Controller
        
        //TBV Delegates
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.estimatedRowHeight = 100
        favoritesView.tableView.rowHeight = UITableViewAutomaticDimension
        
        //favoritesCustomCell.nameLabel.isHidden = true
        
        //Getting saved images to tableView
        FileManagerHelper.manager.loadFavorites()
        self.favoriteImages = FileManagerHelper.manager.getFavoriteImagesFromFileManager()
        print(self.favoriteImages)
        
        //TODO: - button action
        //currentCell.deleteImgButton.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
    }
    
    @objc func deleteCell() {
        //TODO: custom delegation to delete the row when delete button is clicked
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
        cell.nameLabel.isHidden = true
        return cell
    }
}


extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath) as! CityImageTableViewCell
        
        let cityName = ""
        
        currentCell.nameLabel.text = "test"
        currentCell.nameLabel.isHidden = false
        currentCell.nameLabel.backgroundColor = .black
        currentCell.nameLabel.layer.cornerRadius = 3.0
        currentCell.nameLabel.layer.masksToBounds = true
        
        
        currentCell.configureTableViewCell(for: cityName) //HOW TO PASS IN CITY NAME!
        
        //MARK: nameLabel animation
        let animation = CABasicAnimation(keyPath: "opacity") //expects a string
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = 2.0
        currentCell.nameLabel.layer.add(animation, forKey: nil) //adding animation to label opacity
        currentCell.nameLabel.layer.opacity = 0 //ending value
    }
}



