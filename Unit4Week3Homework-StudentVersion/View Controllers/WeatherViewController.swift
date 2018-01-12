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
    var keyWord = "60613" //what the user enters into the textField
    var weeklyForecast = [SevenDayForecast](){
        didSet {
            weatherView.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateCloudImage()
        print("its animating")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.backgroundColor = .white
        view.backgroundColor = .white
        navigationItem.title = "7 Day Forecast"
        
        //CV Delegates
        view.addSubview(weatherView)

        view.addSubview(cloudImage1)
        view.addSubview(cloudImage2)
        view.addSubview(cloudImage3)
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
    
    lazy var cloudImage1: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 20, width: 500, height: weatherView.bounds.height)) //will give constraints later
        iv.image = UIImage(named: "clouds")
        iv.backgroundColor?.withAlphaComponent(0.5)
        return iv
    }()
    
    
    lazy var cloudImage2: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: view.bounds.width, y: 20, width: 500, height: weatherView.bounds.height))
        iv.image = UIImage(named: "clouds")
        iv.backgroundColor?.withAlphaComponent(0.5)
        return iv
    }()
    
    lazy var cloudImage3: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: view.bounds.width, y: 20, width: 500, height: weatherView.bounds.height))
        iv.image = UIImage(named: "clouds")
        iv.backgroundColor?.withAlphaComponent(0.5)
        return iv
    }()
    

    
    
    func animateCloudImage(){
        
        let rightToLeft = CATransform3DMakeTranslation(-1000, 0, 0)
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "transform")
        keyFrameAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        keyFrameAnimation.values = [CATransform3DIdentity,rightToLeft]
        
        
        keyFrameAnimation.duration = 30
        keyFrameAnimation.repeatCount = Float.infinity
        
        cloudImage1.layer.add(keyFrameAnimation, forKey: nil)
        cloudImage1.alpha = 0.15
        let delay = DispatchTime.now() + 2.3
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            self.cloudImage2.layer.add(keyFrameAnimation, forKey: nil)
            self.cloudImage2.alpha = 0.15
            let delay2 = DispatchTime.now() + 14.3
            self.cloudImage1.stopAnimating()
            DispatchQueue.main.asyncAfter(deadline: delay2, execute: {
                self.cloudImage3.layer.add(keyFrameAnimation, forKey: nil)
                self.cloudImage3.alpha = 0.15
                
            })
            
        })
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        cell.backgroundColor = .black
        
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
       // if let textFieldAsStr = text{
            UserDefaultsHelper.manager.setZipcode(to: text)
            print("\(text) zipcode was saved!")
        //}
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


