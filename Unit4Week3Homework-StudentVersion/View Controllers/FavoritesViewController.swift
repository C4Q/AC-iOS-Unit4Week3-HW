//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit


class FavoritesViewController: UIViewController{
    
    
    let emptyStateView = EmptyStateView()
    var sampleCityArray = [#imageLiteral(resourceName: "Chicago-IL"), #imageLiteral(resourceName: "Hastings"), #imageLiteral(resourceName: "phili"), #imageLiteral(resourceName: "tokyo")] //testing ONLY
    let favoritesView = FavoritesView()
    let weatherVC = WeatherViewController()
    let cityCustomCell = CityImageTableViewCell()
    private var keyword: String!
    
    //dependency injection for city name?
    
    var forecast = [SevenDayForecast]()
    
    var pixabayImage: PixabayImage!
    
    var favoriteImages = [UIImage]() {
        didSet {
            favoritesView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if favoriteImages.isEmpty {
        //            view.addSubview(emptyStateView)
        //            emptyStateView.snp.makeConstraints({ (make) in
        //                make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        //            })
        //             print("empty state added")
        //        } else {
        view.addSubview(favoritesView) //adding the custom view into the View Controller
        //}
        
        //TBV Delegates
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        FileManagerHelper.manager.delegate = self
        favoritesView.tableView.estimatedRowHeight = 100
        favoritesView.tableView.rowHeight = UITableViewAutomaticDimension
        
        //Getting saved images to tableView
        FileManagerHelper.manager.loadFavorites()
        self.favoriteImages = FileManagerHelper.manager.getFavoriteImagesFromFileManager()
        print(self.favoriteImages)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityImageCell", for: indexPath) as! CityImageTableViewCell
        let cityImage = favoriteImages[indexPath.row]
        cell.cityImageView.image = cityImage
        cell.nameLabel.isHidden = true
        return cell
    }
}


extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: Getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath) as! CityImageTableViewCell
        //currentCell = favoriteImages[indexPath.row]
        let cityName = keyword
        
        currentCell.nameLabel.text = "test"//cityName
        currentCell.nameLabel.isHidden = false
        currentCell.nameLabel.backgroundColor = .black
        currentCell.nameLabel.layer.cornerRadius = 3.0
        currentCell.nameLabel.layer.masksToBounds = true
        
        //HOW TO PASS IN CITY NAME?!
        //currentCell.configureTableViewCell(for: currentCell.nameLabel.text!)
        
        //MARK: Name label animation
        let animation = CABasicAnimation(keyPath: "opacity") //expects a string
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = 2.0
        currentCell.nameLabel.layer.add(animation, forKey: nil) //adding animation to label opacity
        currentCell.nameLabel.layer.opacity = 0 //ending value
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if !favoriteImages.isEmpty {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if !favoriteImages.isEmpty {
            if editingStyle == .delete {
                tableView.beginUpdates()
                favoriteImages.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                FileManagerHelper.manager.removeFavorite(from: indexPath.row)
                tableView.endUpdates()
            }
        }
    }
}

//MARK: Custom delegate extension
extension FavoritesViewController: FileManagerDelegate {
    func didRefresh(_ service: FileManagerHelper, favoriteImage: [UIImage]) {
        self.favoriteImages = favoriteImage
        favoritesView.tableView.reloadData()
        print("image added")
    }
}





