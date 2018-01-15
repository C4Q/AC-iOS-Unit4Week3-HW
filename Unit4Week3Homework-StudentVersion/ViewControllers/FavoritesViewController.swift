//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    //var sampleCityArray = [#imageLiteral(resourceName: "chicago"), #imageLiteral(resourceName: "Hastings"), #imageLiteral(resourceName: "phili"), #imageLiteral(resourceName: "tokyo")]
    
    let favoritesView = FavoritesView()
    let favoritesCustomCell = CityImageTableViewCell()
    
    var favoritedImages = [UIImage]() {
        didSet {
            print("Data set")
            favoritesView.tableView.reloadData()
            for stuff in favoritedImages {
                print(stuff)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(favoritesView) //adding the custom view into the View Controller
        
        //Load Favorite Images from File Manager to VC
        FileManagerHelper.manager.loadFavorites()
        self.favoritedImages = FileManagerHelper.manager.getFavoritesImages()
        
        //TBV Delegates
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.estimatedRowHeight = 80
        favoritesView.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTable()
    }
    
    func animateTable() {
        favoritesView.tableView.reloadData()
        let cells = favoritesView.tableView.visibleCells
        let tableViewHeight = favoritesView.tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityImageCell", for: indexPath) as! CityImageTableViewCell
        
        let cityImage = favoritedImages[indexPath.row]
        
        cell.cityImageView.image = cityImage

        return cell
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    
}








