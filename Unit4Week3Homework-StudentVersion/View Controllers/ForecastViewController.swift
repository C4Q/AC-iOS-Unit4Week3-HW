//
//  ForecastViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
        
    let forecastView = ForecastView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(forecastView)
    }

}
