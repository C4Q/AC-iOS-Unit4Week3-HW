//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var city: String
    var forecast: Forecast
    var imageUrl = ""
    
    var detailView = WeatherDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailView)
        view.addSubview(setupBlurEffectView())
        setupLabelsAndImage()
    
        detailView.saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
    }
    
    @objc func saveImage() {
        
        if DataPersistenceHelper.manager.addFavoritedImage(city: city, imgUrl: imageUrl, image: detailView.cityImageView.image!) {
            
            
            UIView.animate(withDuration: 2.0, animations: {
                self.detailView.cityImageView.layer.opacity = 0.0
                self.detailView.cityImageView.transform = CGAffineTransform(translationX: self.view.bounds.maxX * 0.66, y: self.view.bounds.maxY).scaledBy(x: 0.001, y: 0.001)
                
            }) { if $0 {
                UIView.animate(withDuration: 1.0, animations: {
                }, completion: nil)
                self.detailView.cityImageView.layer.opacity = 1.0
                self.detailView.cityImageView.transform = CGAffineTransform.identity
                self.alertController(title: "Success", message: "You have saved the image.")
                self.detailView.saveButton.isEnabled = false
                } }
            
            
        } else {
            alertController(title: "Error", message: "Something went wrong.")
        }
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    init(city: String, forecast: Forecast) {
        self.city = city
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("nah")
    }
    
    private func setupBlurEffectView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        visualEffect.tag = 999
        return visualEffect
    }
    
    func setupLabelsAndImage() {

        PixabayAPIClient.manager.getImages(searchTerm: city, completionHandler: { self.imageUrl = $0.webformatURL; ImageHelper.manager.getImage(from: $0.webformatURL, completionHandler: { self.detailView.cityImageView.image = $0; self.detailView.saveButton.isEnabled = true; self.view.viewWithTag(999)?.removeFromSuperview() }, errorHandler: { print($0); self.view.viewWithTag(999)?.removeFromSuperview() }) }, errorHandler: { print($0) })
        
        detailView.titleLabel.text = city
        detailView.conditionLabel.text = forecast.weather
        detailView.highLabel.text = "High: \(forecast.maxTempF.description)"
        detailView.lowLabel.text = "Low: \(forecast.minTempF.description)"
        detailView.precipitationLabel.text = "Rainfall: \(forecast.precipIN.description)"
        detailView.windspeedLabel.text = "Windspeed: \(forecast.windSpeedMPH.description)"
        detailView.sunriseLabel.text = "Sunrise: \(forecast.sunrise.description)"
        detailView.sunsetLabel.text = "Sunset: \(forecast.sunset.description)"
    }
    
    func alertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
}
