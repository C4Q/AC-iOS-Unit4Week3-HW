//
//  DetailedVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {
    
    let detailView = DetailedView()
    var forecast: Forecast
    
   
    //Dependency Injection
    
    init(forecast: Forecast) {
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    
   
    
    
    
    
}
