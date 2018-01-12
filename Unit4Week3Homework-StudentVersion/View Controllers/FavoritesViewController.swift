//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var sampleCityArray = [#imageLiteral(resourceName: "Chicago-IL"), #imageLiteral(resourceName: "Hastings"), #imageLiteral(resourceName: "phili"), #imageLiteral(resourceName: "tokyo")] //testing ONLY
    
    let favoritesView = FavoritesView()
    let favoritesCustomCell = CityImageTableViewCell()
    
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
        //TODO: -  Animation: when user taps on cell, city name appears
        
      
//        UIView.animate(withDuration: 5.0, animations: {
//            self.favoritesCustomCell.nameLabel.isHidden = false
//        })
        favoritesCustomCell.nameLabel.isHidden = false
        animatenameLabel()
        
        

        //let cityName = favoriteImages[indexPath.row]
        
        
        
    }
  }

extension FavoritesViewController{
    func animatenameLabel(){
        favoritesCustomCell.nameLabel.isHidden = false
        //let animation = CATransform3DMakeTranslation(-1000, 0, 0)
        
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        //animation.values = [CATransform3DIdentity,rightToLeft]
        animation.duration = 10
        animation.repeatCount = 1
        favoritesCustomCell.nameLabel.layer.add(animation, forKey: nil)
        favoritesCustomCell.nameLabel.alpha = 1.0
        favoritesCustomCell.nameLabel.isHidden = true
    }
    
//    func animateOpacity(){
//        //using core animation
//
//        //create animation for shadowOpacity of the imageView.layer.opacity
//        let animation = CABasicAnimation(keyPath: "opacity") //expects a string
//        //animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        let customTimingFunction = CAMediaTimingFunction(controlPoints: 1, 0.22, 0.33, 0.67)
//        animation.timingFunction = customTimingFunction
//        animation.fromValue = 1.0
//        animation.toValue = 0
//        animation.duration = 2.0
//        //adding animation to imageborder
//        ImageView.layer.add(animation, forKey: nil)
//        // no final value wanted because we do not want the animation to stay
//    }
}





