//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    let detailView = DetailView()
    var picture: PixabayResults?
    var imageURL = String()
    
    var weatherObject: Weather!
    var cityName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        constraintView()
        setView()
        PixabayAPIClient.manager.getImages(from: cityName.replacingOccurrences(of: " ", with: "%20"), completionHandler: {self.imageURL = $0.webformatURL
            ImageAPIClient.manager.loadImage(from: self.imageURL, completionHandler: {self.detailView.cityImage.image = $0}, errorHandler: {print($0)})
        }, errorHandler: {print($0)})
        navigationItem.title = cityName
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImage))
    }
    
    @objc func saveImage() {
        guard let image = detailView.cityImage.image else { return }
//        guard let imageURL = imageURL else {return}
        //TODO: Save Image
        KeyedArchiverClient.shared.saveImageToDisk(image: image, artworkPath: imageURL)
        alert()
    }
    
    func alert() {
        let alert = UIAlertController(title: "Saved", message: "You saved the Image!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setView() {
        if let cityName = cityName {
        detailView.cityDateLabel.text = "Weather forecast in \(cityName) for \(Date.dateStringFromTimeInterval(timeinterval: TimeInterval(weatherObject.timestamp))) "
        }
        //TODO: Image
        
        detailView.weatherDescriptionLabel.text = weatherObject.weather
        detailView.highLabel.text = "High: \(weatherObject.maxTempF)\u{00B0}F"
        detailView.lowLabel.text = "Low: \(weatherObject.minTempF)\u{00B0}F"
        detailView.sunriseLabel.text = "Sunrise: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(weatherObject.sunrise)))"
        detailView.sunsetLabel.text = "Sunset: \(Date.timeStringFromTimeInterval(timeinterval: TimeInterval(weatherObject.sunset)))"
        detailView.windspeedLabel.text = "Windspeed: \(weatherObject.windSpeedMPH) MPH"
        detailView.precipitationLabel.text = "Precipitation: \(weatherObject.precipIN)"
    }
    
    func constraintView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
    }


}

