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
        guard let image = detailedWeatherView.detailImageView.image else { return }
        FileManagerHelper.manager.saveImage(with: pixaBayImages[0].webformatURL, image: image)
        FileManagerHelper.manager.addNew(savedImage: pixaBayImages[0])
        
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
        let urlStr =  pixaBayImages[0].webformatURL
        guard let url = URL(string: urlStr)  else { print("Problem with url"); return }
        if let picture = ImageCache.manager.cachedImage(url: url) {
            self.detailedWeatherView.detailImageView.image = picture
            self.detailedWeatherView.nameToSaveAs = urlStr
            return
        }
        DispatchQueue.main.async {
            ImageCache.manager.processImageInBackground(imageURL: url, completion: {(error: Error?, image: UIImage?) in
                self.detailedWeatherView.detailImageView.image = image
            })
            
            
        }
    }
    
}
