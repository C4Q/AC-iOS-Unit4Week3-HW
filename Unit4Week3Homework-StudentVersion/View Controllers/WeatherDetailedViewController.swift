//
//  WeatherDetailedViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailedViewController: UIViewController {

    let detailedWeatherView = WeatherDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailedWeatherView)
        view.backgroundColor = UIColor.darkGray
        navigationItem.title = "City Name Here"
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
