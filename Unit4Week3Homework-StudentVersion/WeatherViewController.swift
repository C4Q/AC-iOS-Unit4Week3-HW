//
//  ViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController{

    let cellSpacing: CGFloat = 5.0
    let weatherView = WeatherView()
   
    var forecast = [Forecast](){
        didSet{
         weatherView.collectionView.reloadData()
        }
    }
    
    var searchedZip: String?{
        didSet{
            loadDataBySearch()
            ZipCodeHelper.manager.getLocationName(from: searchedZip!, completionHandler: { self.navigationController?.navigationBar.topItem?.title = $0}, errorHandler: {print($0)})
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(weatherView)
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.zipTextField.delegate = self
        
        if UserDefaultHelper.manager.getZip() == nil{
            loadDataBySearch()
        }else{
            loadDataBySave()
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        ZipCodeHelper.manager.getLocationName(from: UserDefaultHelper.manager.getZip() ?? "11365", completionHandler: { self.navigationController?.navigationBar.topItem?.title = $0}, errorHandler: {print($0)})
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func loadDataBySearch(){
       
        let urlStr = "https://api.aerisapi.com/forecasts/\(searchedZip ?? "11365")?client_id=snB0ftjSKJUMR4953Uxwj&client_secret=xfTI97bFbDDjfw7iuCx6Q70AZd29AGTjBejDoNBR"
        WeatherAPIClient.manager.getForecast(from: urlStr, completionHandler: {self.forecast = $0
            if self.searchedZip != nil{
                UserDefaultHelper.manager.setZip(to: self.searchedZip!)
            }
        }, errorHandler: {print($0)})
        
    }
    
    func loadDataBySave(){
        
        let urlStr = "https://api.aerisapi.com/forecasts/\(UserDefaultHelper.manager.getZip()!)?client_id=snB0ftjSKJUMR4953Uxwj&client_secret=xfTI97bFbDDjfw7iuCx6Q70AZd29AGTjBejDoNBR"
        WeatherAPIClient.manager.getForecast(from: urlStr, completionHandler: {self.forecast = $0        }, errorHandler: {print($0)})
    }
}










extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedForecast = forecast[indexPath.row]
            let destination = ForecastDetailViewController(forecast: selectedForecast)
            destination.modalTransitionStyle = .crossDissolve
            destination.modalPresentationStyle = .overCurrentContext
            present(destination, animated: true, completion: nil)

    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        
        
        if !forecast.isEmpty{
        let forecastToSet = forecast[indexPath.row]
            cell.titleLabel.text = Date.dateStringFromTimeInterval(timeinterval: TimeInterval(forecastToSet.timestamp))
            cell.titleLabel.font = cell.titleLabel.font.withSize(20)
            cell.highLabel.text = "High: " + forecastToSet.maxTempF.description + "°F"
        cell.lowLabel.text = "Low: "  + forecastToSet.minTempF.description + "°F"
        cell.forecastImage.image = UIImage(named: forecastToSet.icon.replacingOccurrences(of: ".png", with: ""))
        }
        
        return cell
    }
    
    
    
    
    
    
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 2
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}


extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchedZip = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
