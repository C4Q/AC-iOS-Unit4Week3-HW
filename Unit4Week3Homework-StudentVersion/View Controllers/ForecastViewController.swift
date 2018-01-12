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
    
    let cellSpacing = UIScreen.main.bounds.width * 0.02
    
    var forecasts = [Forecast]() {
        didSet {
            forecastView.collectionView.reloadData()
            forecastView.collectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(forecastView)
        
        forecastView.collectionView.dataSource = self
        forecastView.collectionView.delegate  = self
        forecastView.searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let myDefaults = UserDefaultsHelper.manager.getValue() {

        forecastView.searchTextField.text = myDefaults.zipCode.description
        
        AerisWeatherAPIClient.manager.getForecast(zip: myDefaults.zipCode.description, completionHandler: { self.forecasts = $0; ZipCodeHelper.manager.getLocationName(from: myDefaults.zipCode.description, completionHandler: { self.forecastView.cityNameLabel.text = $0 }, errorHandler: { print($0) }) }, errorHandler: { print($0); self.alertController(title: "No Data", message: "No forecast data for the provided zip code.") })
        }
        
        
        
    }

}

// Collection View Data Source
extension ForecastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        if let myDefaults = UserDefaultsHelper.manager.getValue() {
            switch myDefaults.measurementSystem {
            case 0:
                let forecast = forecasts[indexPath.row]
                cell.dateLabel.text = forecast.dateTimeISO.components(separatedBy: "T")[0]
                cell.conditionImageView.image = UIImage(imageLiteralResourceName: forecast.icon)
                cell.highLabel.text = "High: \(forecast.maxTempF.description) ℉"
                cell.lowLabel.text = "Low: \(forecast.minTempF.description) ℉"
                
                
                
            case 1:
                
                
                let forecast = forecasts[indexPath.row]
                cell.dateLabel.text = forecast.dateTimeISO.components(separatedBy: "T")[0]
                cell.conditionImageView.image = UIImage(imageLiteralResourceName: forecast.icon)
                cell.highLabel.text = "High: \(forecast.maxTempC.description) ℃"
                cell.lowLabel.text = "Low: \(forecast.minTempC.description) ℃"
                
                
            default:
                break
                
            }
        } else {
            let forecast = forecasts[indexPath.row]
            cell.dateLabel.text = forecast.dateTimeISO.components(separatedBy: "T")[0]
            cell.conditionImageView.image = UIImage(imageLiteralResourceName: forecast.icon)
            cell.highLabel.text = "High: \(forecast.maxTempF.description) ℉"
            cell.lowLabel.text = "Low: \(forecast.minTempF.description) ℉"
            
            return cell
        }
        return cell
    }
    
}

// Collection View Flow Layout
extension ForecastViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3.2
        let numSpaces: CGFloat = numCells + 1
        
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        
        return CGSize(width: (collectionViewWidth - (cellSpacing * numSpaces)) / numCells, height: collectionViewHeight * 0.90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}

extension ForecastViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = WeatherDetailViewController(city: forecastView.cityNameLabel.text!, forecast: forecasts[indexPath.row])
        
        present(detailVC, animated: true, completion: nil)
        
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        visualEffect.tag = 999
        view.addSubview(visualEffect)
    }
    
}

extension ForecastViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else { textField.resignFirstResponder(); return false }
        guard let zip = Int(text), text.count == 5 else { textField.resignFirstResponder(); alertController(title: "Invalid Input", message: "Please enter a valid zip code."); return false }
        

        
        AerisWeatherAPIClient.manager.getForecast(zip: zip.description, completionHandler: { self.forecasts = $0; ZipCodeHelper.manager.getLocationName(from: zip.description, completionHandler: { self.forecastView.cityNameLabel.text = $0 }, errorHandler: { print($0) }) }, errorHandler: { print($0); textField.resignFirstResponder(); self.alertController(title: "No Data", message: "No forecast data for the provided zip code.") })
        
        textField.resignFirstResponder();
        return true
    }
    
    func alertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
}


