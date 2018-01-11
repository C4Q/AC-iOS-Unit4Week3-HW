//
//  WeatherDetailedViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailedViewController: UIViewController {
    
    //if segue continues not to work, use dependency injection
    //Dependency Injection
    init(fullWeatherDetail: Weather) {
        self.fullWeatherDetail = fullWeatherDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let detailedWeatherView = WeatherDetailView()
    var fullWeatherDetail: Weather!
    var pixaBayImages = [Pixabay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailedWeatherView)
        view.backgroundColor = UIColor.darkGray
        navigationItem.title = "City Name Here"
        setUpWeatherDetailWithInformation()
    }
    
    
    func setUpWeatherDetailWithInformation() {
        print(fullWeatherDetail)
        detailedWeatherView.cityLabel.text = "City Name Here"
        detailedWeatherView.shortWeatherDescriptionLabel.text = fullWeatherDetail.weather
        detailedWeatherView.weatherStatusTextView.text = """
        High: \(fullWeatherDetail.maxTempF.description)
        Low: \(fullWeatherDetail.minTempF.description)
        Sunrise: \(fullWeatherDetail!.sunriseISO.components(separatedBy: "T")[1].components(separatedBy: "-")[0])
        Sunset: \(fullWeatherDetail.sunsetISO.components(separatedBy: "T")[1].components(separatedBy: "-")[0])
        Wind Speed: \(fullWeatherDetail.windSpeedMPH.description)
        Precipitation: \(fullWeatherDetail.precipIN.description)
        """
        
    }
    
    
    func setUpSaveButton() {
        let rightButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.savePhoto))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func savePhoto() {
        //        FileManagerHelper.saveImage(<#T##FileManagerHelper#>)
    }
    
    func loadImage() {
        let cityName = "Minneapolis"
        guard let url = URL(string: "https://pixabay.com/api/?key=7289853-358e04da32397e66454c4e725&q=\(cityName)") else { return }
        let completion: ([Pixabay]) -> Void = { (onlineImages: [Pixabay]) in
            self.pixaBayImages = onlineImages
        }
        let errorHandler: (Error) -> Void = { (error: Error) in
            print(error.localizedDescription)
        }
        PixabayAPIClient.manager.getPixaBayImages(from: url, completionHandler: completion, errorHandler: errorHandler)
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
