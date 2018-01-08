//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    let detailView = WeatherDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(detailView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
