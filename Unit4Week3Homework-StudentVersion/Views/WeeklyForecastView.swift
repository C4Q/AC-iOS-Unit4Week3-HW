//
//  WeeklyForecastView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeeklyForecastView: UIView {
    
    // TODO:
    //    Create View
    //    Main View To Contain:
    //    A Label that names the city for the forecast
    //    A CollectionView to show the forecasts
    //    A TextField for the user to enter the zip code
    //    Selecting a collection view cell should segue to a weather detail view controller
    
    
    //SETTING UP CV
    //Label
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        if UserDefaultHelper.manager.getZip() != nil {
        ZipCodeHelper.manager.getLocationName(from: UserDefaultHelper.manager.getZip()!, completionHandler: {label.text = "Weather Forecast for " + $0 }, errorHandler: {print($0)})
    }
        return label
    }()
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //SETTING UP CELL
        cv.register(ForecastCell.self, forCellWithReuseIdentifier: "ForecastCell") //Registering Cell
        cv.backgroundColor = .white
        
        return cv
    }()
    
    //Text Field
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Zip Code"
        tf.allowsEditingTextAttributes = true
        tf.textAlignment = .center
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .lightText
//        tf.keyboardType = .numberPad
        return tf
    }()
    
    //SET UP CUSTOM VIEW
    //Saved to snippets
    override init(frame: CGRect) { // Required : Progamatic
        super.init(frame: UIScreen.main.bounds)
        commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) { // Required : Storyboard - Only checks if this is here but does not use it if there is no storyboard
        super.init(coder: aDecoder)
        commoninit()
    }
    
    private func commoninit() { // Add all functions that set constraints, then place in both required inits
        setUpLabel()
        setUpCollectionView()
        setUpTextField()
    }
    
    func setUpLabel() {
        addSubview(label)
        let sf = safeAreaLayoutGuide
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: sf.topAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: sf.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: sf.trailingAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
    }
    
    func setUpCollectionView() {
        addSubview(collectionView)
        let sf = safeAreaLayoutGuide
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: sf.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: sf.trailingAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: sf.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setUpTextField() {
        addSubview(textField)
           let sf = safeAreaLayoutGuide
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 22).isActive = true
        textField.widthAnchor.constraint(equalTo: sf.widthAnchor, multiplier: 0.5)
        textField.centerXAnchor.constraint(equalTo: sf.centerXAnchor).isActive = true
    }
    
//    func loadZip() {
//        guard (textField.text?.count)! < 6 else {return}
//        if textField.text?.count == 5 {
//            
//        }
    }
    


