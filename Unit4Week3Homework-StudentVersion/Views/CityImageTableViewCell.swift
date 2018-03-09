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
    
    //cityLabel
    lazy var nameLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        //label.text = "cityName".uppercased()
        return label
    }()
    

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
        setUpGUI()
    }
    
    private func setUpGUI() { //Each function in here represents the objects being created. By doing this, we can reuse the same code without typing over and over again.
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        
        //ARRAY MUST BE ON ORDER!!
        let tableViewCellObjects = [cityImageView, nameLabel] as [UIView]
        
        tableViewCellObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        
        contentView.addSubview(cityImageView)
        
        NSLayoutConstraint.activate([
            //city Image
            cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //nameLabel
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }
    
    //MARK: - configure table view cell
    public func configureTableViewCell(for cityName: String){ //pass in forecast
        //setting properties for the custom collection view cell
        //nameLabel.text = "\(cityName)"
       
    }
    
}
