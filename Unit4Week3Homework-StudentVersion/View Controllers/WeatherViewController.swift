//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let sampleArray = [1,2,3,4,5,6] //for testing ONLY
    let weatherView = WeatherView()
    let cellSpacing: CGFloat =  10.0
    var keyWord = "" //what the user enters into the textField
    var weeklyForecast = [SevenDayForecast](){
        didSet {
            weatherView.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = "7 Day Forecast"
        
        //CV Delegates
        view.addSubview(weatherView)
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.textField.delegate = self
        
        
        //loading most recent zipcode from user defaults
        if let savedZipcode = UserDefaultsHelper.manager.getZipcode() {
            weatherView.textField.text = String(savedZipcode)
            print("zipcode loaded from UD")
        } else {
            weatherView.textField.text = ""
        }
        //loading saved forecast from sandbox
        //loadSavedForecastFromSandBox()
        
    }
    
    //    func loadSavedForecastFromSandBox(){
    //        //load forecast from sandbox to FM
    //        FileManagerHelper.manager.sendForecastToFileManager(forecast: weeklyForecast, with: keyWord)
    //        print("forecast loaded from sanbox to fm")
    //        //load forecast from FM to VC
    //        FileManagerHelper.manager.loadForecastFromFileManager(using: keyWord)
    //        print("forecast loaded from fm to vc")
    //    }
    
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        cell.backgroundColor = .white
        
        let forcast = weeklyForecast[indexPath.row]
        
        cell.configureCollectionViewCell(for: forcast) //inside weather collection view cell
        
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Using dependency injection to pass Fellow Model Object to DetailVC
        //Seguing information over to the DWVC
        let forecast = weeklyForecast[indexPath.row]
        let cityName = keyWord
        
        let detailWVC = DetailWeatherViewController()//take in things that we need in the DVC that we already have in the WVC?
        detailWVC.modalTransitionStyle = .crossDissolve
        detailWVC.modalPresentationStyle = .overCurrentContext
        detailWVC.detailView.configureDetailView(forecast: forecast, city: cityName )
        present(detailWVC, animated: true, completion: nil)
        
        
        //MARK: - Making Pixabay API Call to get random city image
        
        //Pixabay API completion
        let loadImageFromInternet: (PixabayImage) -> Void = {(onlineImage: PixabayImage) in
            //make Image API call
            
            //Image API completion
            let setImageToOnlineImage: (UIImage) -> Void = {(onlineImageTwo: UIImage ) in
                
                detailWVC.detailView.cityImageView.image = onlineImageTwo
                detailWVC.detailView.cityImageView.setNeedsLayout()
                detailWVC.detailCityImage = onlineImage.webURL //image based on user input
            }
            ImageAPIClient.manager.loadImage(from: onlineImage.webURL, //get image from webURL String
                completionHandler: setImageToOnlineImage,
                errorHandler: {print($0)})
        }
        PixabayAPIClient.manager.getCityImage(from: keyWord, //get pic based off of what the user inputs
            completionHandler: loadImageFromInternet,
            errorHandler: {print($0)})
        
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
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

extension WeatherViewController: UITextFieldDelegate {
    
    //Did Begin Editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    //Changing Characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // guard textField.text != nil else {return false}
        
        //handling for numbers only
        let allowedCharacters = CharacterSet.decimalDigits //digits ONLY
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    //Should Return
    //MARK: - Meat of the functionality
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {return true}
        
        //check to make sure zipcode is ONLY 5 numbers long
        if text.count != 5 {
            textField.text = ""
        }
        //calling userDefaults to save zipcode entered
        if let textFieldAsInt = Int(text){
            UserDefaultsHelper.manager.setZipcode(to: textFieldAsInt)
            print("\(textFieldAsInt) zipcode was saved!")
        }
        //setting the empty string to whatever the user inputs
        keyWord = text
        
        //MARK: - Weather API call: save forecast to file manager in completion handler in the weather API call
        //string being used to pass into Weather API call
        //TODO: check  why it's giving me back a french name always
        
        let urlStr = "https://api.aerisapi.com/forecasts/\(keyWord)?client_id=\(APIKeys.weatherClientID)&client_secret=\(APIKeys.weatherSecretKey)"
        
        //set completion
        let loadForecastFromInternet: ([SevenDayForecast]) -> Void = {(onlineForcast: [SevenDayForecast]) in
            self.weeklyForecast = onlineForcast
            print("7 Day Forecast exists!")
          
            //MARK: - ZipCode call to get name of city
            let zipCodeToNameConversion: (String) -> Void = {(cityName: String) in
                self.keyWord = cityName
                print(self.keyWord)
                self.weatherView.messageLabel.text = "Weather forecast for \(self.keyWord)"
            }
            print(self.keyWord)
            ZipCodeHelper.manager.getLocationName(from: self.keyWord,
                                                  completionHandler: zipCodeToNameConversion,
                                                  errorHandler: {print($0)})
        }
        WeatherAPIClient.manager.getForecast(from: urlStr,
                                             completionHandler: loadForecastFromInternet,
                                             errorHandler: {print($0)})

        print(self.keyWord)
        
        textField.resignFirstResponder()
        return true
    }
}


