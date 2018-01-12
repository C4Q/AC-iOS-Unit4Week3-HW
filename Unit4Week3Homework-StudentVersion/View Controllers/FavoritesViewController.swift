//
//  FavoritesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesView = FavoritesView()
    
    let cellSpacing: CGFloat = 0.0
    
    var favoritedImages = [DataPersistenceHelper.FavoritedImage]() {
        didSet {
            favoritesView.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(favoritesView)
        
        favoritesView.collectionView.dataSource = self
        favoritesView.collectionView.delegate = self
                
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Alert if no data yet
        if favoritedImages.isEmpty {
            alertController(title: "No Saved Data", message: "Save some images!")
        }
    }
    
    // Load and retrieve saved hands in view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataPersistenceHelper.manager.loadFavoritedImages()
        favoritedImages = DataPersistenceHelper.manager.getFavoritedImages()
    }
    
    func alertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }

    
    

}

// Collection View Data Source
extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritedImages.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCollectionViewCell
                
        let favoritedImage = favoritedImages[indexPath.row]
        
        ImageHelper.manager.getImage(from: favoritedImage.imgUrl, completionHandler: { cell.cityImageView.image = $0 }, errorHandler: { print($0) })
        
        return cell
    }
    
}

// Collection View Flow Layout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        
        return CGSize(width: collectionViewWidth , height: collectionViewHeight / numCells)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}



