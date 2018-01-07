//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var sampleCityArray = [#imageLiteral(resourceName: "Chicago-IL"), #imageLiteral(resourceName: "Hastings"), #imageLiteral(resourceName: "phili"), #imageLiteral(resourceName: "tokyo")]
    
    let favoritesView = FavoritesView()
    let favoritesCustomCell = CityImageTableViewCell()
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        favoritesView.tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(favoritesView) //adding the custom view into the View Controller
        //contentView.addSubview(favoritesCustomCell.cityImageView)
        
        //TBV Delegates
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.estimatedRowHeight = 80
        favoritesView.tableView.rowHeight = UITableViewAutomaticDimension
        //favoritesView.tableView.separatorStyle = .none
 
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleCityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityImageCell", for: indexPath) as! CityImageTableViewCell
        
        //cell.textLabel?.text = "Table Views... Good Stuff"
        
        let cityImage = sampleCityArray[indexPath.row]
        
        cell.imageView?.image = cityImage
        
       
        //TODO will be passing in a fellow object here
        //cell.configureTableViewCellFor(fellow: fellow)
        
//        func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
//            
//            
//            var scale = CGFloat(max(size.width/image.size.width,
//                                    size.height/image.size.height))
//            var width:CGFloat  = image.size.width * scale
//            var height:CGFloat = image.size.height * scale;
//            
//            let rr:CGRect = CGRect( x: 0, y: 0, width: width, height: height)
//            
//            UIGraphicsBeginImageContextWithOptions(size, false, 0);
//            image.draw(in: rr)
//            let newImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext();
//            return newImage!
//        }
        
        return cell
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let cell = tableView.cellForRow(at: indexPath) as! FellowTableViewCell
//        let fellow = fellows[indexPath.row]
//
//        var cellImage: UIImage!
//        if let image = cell.profileImageView.image {
//            cellImage = image
//        } else {
//            cellImage = UIImage(named: "placeholder-image")
//        }
//
//        //TODO: use dependency injection to pass Fellow Model Object to DetailVC
//        //-> passing anything that the destination VC needs
//        //setting up what the modal presentation will look like
//        let detailViewController = DetailViewController(fellow: fellow, image: cellImage)
//        detailViewController.modalTransitionStyle = .crossDissolve
//        detailViewController.modalPresentationStyle = .overCurrentContext
//        present(detailViewController, animated: true, completion: nil)
//
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
//
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        // optionally, return an calculated estimate for the cell heights
//        return 200
//    }

}



