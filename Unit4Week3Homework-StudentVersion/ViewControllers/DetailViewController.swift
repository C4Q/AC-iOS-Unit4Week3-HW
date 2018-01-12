//
//  DetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //Dependency Injection
    init(forcast: WeatherInfo, cityName: String) {
        self.forcast = forcast
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var forcast: WeatherInfo
    var cityName: String
    
    let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(detailView)
        detailView.configureView(forecast: forcast, cityName: cityName)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"favoriteU"), style: .plain, target: self, action: #selector(favTapped))
    
    }
    
    @objc func favTapped() {
        FileManagerHelper.manager.addNew(newCityImage: Favorite(cityName: self.cityName))
        FileManagerHelper.manager.saveImage(with: self.cityName, image: detailView.cityImage.image!)
        
        
        
        //saveImage()
    }
    
    func saveImage() {
        
    }
   
}
