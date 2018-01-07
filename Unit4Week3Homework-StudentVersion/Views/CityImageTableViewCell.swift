//
//  CityImageTableViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.

import UIKit

class CityImageTableViewCell: UITableViewCell {
    
    //imageView
    lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    //This is boiler plate for UIView
    // This overrides the default set-up of a tbv cell that noramlly has a textLabel and a detail Text label
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {//We aren't using a storyboard, so we need to tell the app what our screen size is. Storyboard does this for us automatically.
        super.init(style: style , reuseIdentifier: "CityImageCell")
        setUpGUI()
    }
    
    required init?(coder aDecoder: NSCoder) {//Since we are overriding the storyboard, we need to tell our app to initialize this instead as our superview.
        super.init(coder: aDecoder)
        setUpGUI()
        
    }
    
    //this gets called right
    override func layoutSubviews() {
        super.layoutSubviews()
        //you get the frame of the UI elements here
        //        cityImageView.layer.cornerRadius = cityImageView.bounds.width / 2.0
        //        cityImageView.layer.masksToBounds = true // keeps the image withing th bounds
        setUpGUI()
    }
    
    private func setUpGUI() { //Each function in here represents the objects being created. By doing this, we can reuse the same code without typing over and over again.
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        
        //ARRAY MUST BE ON ORDER!!
        let tableViewCellObjects = [cityImageView] as [UIView]
        
        tableViewCellObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        //let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(cityImageView)
        
        NSLayoutConstraint.activate([
            //city Image
            cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            ])
    }
    
    //This data is coming from the json that was used to populate
    //    public func configureTableViewCellFor(fellow: Fellow){
    //        nameLabel.text = fellow.name
    //
    //        if let imageURL = fellow.imageURL {
    //            //If the image is in cache then use that FIRST
    //            if let image = ImageCache.manager.cachedImage(url: imageURL){
    //                profileImageView.image = image
    //            } else {
    //                //If image is not in cache, make the network call to get the image and store in cache
    //                ImageCache.manager.processImageInBackground(imageURL: imageURL,
    //                                                            completion: {(error, image) in
    //                                                                if let error = error {
    //                                                                    print("fellowCell- error processing image: \(error.localizedDescription)")
    //                                                                } else if let image = image {
    //                                                                    DispatchQueue.main.async {
    //                                                                        self.profileImageView.image = image
    //                                                                    }
    //                                                                }
    //                })
    //            }
    //        }else{
    //            cityImageView.image = #imageLiteral(resourceName: "placeholder-image")
    //        }
    //    }
    
}
