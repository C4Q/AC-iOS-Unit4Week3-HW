//
//  WeatherDetailedViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import GameplayKit

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
    var cityName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailedWeatherView)
        view.backgroundColor = UIColor.darkGray
        setUpSaveButton()
        setUpWeatherDetailWithInformation()
        loadPixabayImages()

        print(pixaBayImages)
    }
    
    
    func setUpWeatherDetailWithInformation() {
        print(fullWeatherDetail)
        //        detailedWeatherView.cityLabel.text = "City Name Here"
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
        if let userSavedImage = detailedWeatherView.detailImageView.image {
        FileManagerHelper.manager.addNew(savedImage: userSavedImage)
        }
    }
    
    func loadPixabayImages() {
        guard let url = URL(string: "https://pixabay.com/api/?key=7289853-358e04da32397e66454c4e725&q=\(cityName.replacingOccurrences(of: " ", with: "-"))") else { print("Url not working"); return }
        let completion: ([Pixabay]) -> Void = { (onlineImages: [Pixabay]) in
            self.pixaBayImages = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: onlineImages) as! [Pixabay]
            print(self.pixaBayImages)
            self.setUpImage()
    
        }
        
        
        let errorHandler: (Error) -> Void = { (error: Error) in
            print(error.localizedDescription)
        }
        PixabayAPIClient.manager.getPixaBayImages(from: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
    

    func setUpImage() {
//        detailedWeatherView.detailImageView.image = nil
        let urlStr =  pixaBayImages[0].webformatURL
        guard let url = URL(string: urlStr)  else { print("Problem with url"); return }
        DispatchQueue.main.async {
            guard let rawImageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                guard let onlineImage = UIImage(data: rawImageData) else { return }
                self.detailedWeatherView.detailImageView.image = onlineImage
//                let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//                backgroundImage.contentMode = UIViewContentMode.scaleToFill
//                backgroundImage.image = onlineImage
//                self.detailedWeatherView.detailImageView = backgroundImage
//                self.view.layoutIfNeeded()
//                self.detailedWeatherView.backgroundColor = UIColor(patternImage: onlineImage)
            }
        }
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
