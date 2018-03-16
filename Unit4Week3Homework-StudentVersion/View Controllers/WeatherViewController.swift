//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    //TODO: add progress bar activity indicator when images are loading
    
    //MARK: Global variables
    let weatherView = WeatherView()
    let customCell = CityImageTableViewCell()
    let cellSpacing: CGFloat =  10.0
    var keyWord = "" //what the user enters into the textField
    
    
    var weeklyForecast = [SevenDayForecast](){
        didSet {
            weatherView.collectionView.reloadData()
        }
    }
    
    //MARK: Life Cycle Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateCloudImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        //Adding custom Views
        view.addSubview(weatherView)
        view.addSubview(cloudImage1)
        setUpDelegates()
        setUpVCElements()
        setUpUserDefaults()
        askUserForPermission()
    }
    //MARK: Helper Functions
    func askUserForPermission(){
        //calling the LocationService class
        let _ = LocationService.manager.checkForLocationServices()
    }
    func setUpDelegates(){
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.textField.delegate = self
    }
    func setUpVCElements(){
        weatherView.backgroundColor = .white
        navigationItem.title = "SevenDay"
        weatherView.messageLabel.isHidden = true
        weatherView.zipcodeMessageLabel.isHidden = false
    }
    func setUpUserDefaults(){
        //MARK: getting the last zipcode that was entered by the user
        if let savedZipcode = UserDefaultsHelper.manager.getZipcode() {
            weatherView.textField.text = String(savedZipcode)
        } else {
            weatherView.textField.text = ""
        }
    }
    //MARK: scrolling to beginning of index in Collection View when user enters a new zipcode
    func scrollWhenWeatherChanges(){
        let startIndex = self.weeklyForecast.startIndex
        guard startIndex == 0 else {return}
        //creates an index path based on the startIndex and whatever section you are referencing
        let beginningOfForecastArray = IndexPath(item: startIndex, section: 0)
        weatherView.collectionView.scrollToItem(at: beginningOfForecastArray, at: .left, animated: true)
    }
    
    
    lazy var cloudImage1: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 20, width: 2000, height: view.bounds.height)) //will give constraints later
        iv.image = UIImage(named: "clouds")
        iv.backgroundColor?.withAlphaComponent(0.5)
        return iv
    }()
    
    //MARK: - Cloud animation
    func animateCloudImage(){
        let rightToLeft = CATransform3DMakeTranslation(-1000, 0, 0)
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "transform")
        keyFrameAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        keyFrameAnimation.values = [CATransform3DIdentity,rightToLeft]
        keyFrameAnimation.duration = 30
        keyFrameAnimation.repeatCount = Float.infinity
        cloudImage1.layer.add(keyFrameAnimation, forKey: nil)
        cloudImage1.alpha = 0.15
    }
}

//MARK: - Collection View DataSource
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        let forcast = weeklyForecast[indexPath.row]
        
        cell.configureCollectionViewCell(for: forcast) //inside weather collection view cell
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
}

//MARK: - Collection View Delegate
extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK: Using dependency injection to pass Fellow Model Object to DetailVC
        let forecast = weeklyForecast[indexPath.row]
        let cityName = keyWord
        let detailWVC = DetailWeatherViewController()
        detailWVC.modalTransitionStyle = .crossDissolve
        detailWVC.modalPresentationStyle = .overCurrentContext
        detailWVC.detailView.configureDetailView(forecast: forecast, city: cityName )
        present(detailWVC, animated: true, completion: nil)
        
        //MARK: - Making Pixabay API Call to get random city image
        let loadImageFromInternet: (PixabayImage) -> Void = {(onlineImage: PixabayImage) in
            //Image API completion
            let setImageToOnlineImage: (UIImage) -> Void = {(onlineImageTwo: UIImage) in
                
                detailWVC.detailView.cityImageView.image = onlineImageTwo
                detailWVC.detailView.cityImageView.setNeedsLayout()
                detailWVC.detailCityImage = onlineImage.webURL //image based on user input
            }
            ImageAPIClient.manager.loadImage(from: onlineImage.webURL, //get image from webURL String
                completionHandler: setImageToOnlineImage,
                errorHandler: {print($0)})//will return status code
        }
        PixabayAPIClient.manager.getCityImage(from: keyWord, //get pic based off of what the user inputs
            completionHandler: loadImageFromInternet,
            errorHandler: {print($0)})
        
        //MARK: Spring animation when user clicks on a specific day for details
        let forecastCell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 5, options: [], animations: {
            forecastCell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) }, completion: { finished in
                UIView.animate(withDuration: 0.06, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseIn, animations: { forecastCell!.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: { (_) in
                    self.navigationController?.pushViewController(detailWVC, animated: true)
                })})
    }
}

//MARK: - Collection View Flow Layout
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

//MARK: - TextField Delegate
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.becomeFirstResponder()
    }
    
    //Changing Characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //handling for numbers only
        let allowedCharacters = CharacterSet.decimalDigits //digits ONLY
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    //MARK: - Meat of the functionality
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {return true}
        
        if !weeklyForecast.isEmpty{
            scrollWhenWeatherChanges()
        }
        
        if text.count != 5 {
            textField.text = ""
            invalidZipCodeAlert()
        }
        
        if text < String(00501) && text > String(99950) {
            unknownZipCodeAlert()
        }
        
        //MARK: Calling UserDefaults to save zipcode entered by user
        UserDefaultsHelper.manager.setZipcode(to: text)
        print("\(text) zipcode was saved!")
        
        keyWord = text //user entry == textfield.text
        
        let loadForecastFromInternet: ([SevenDayForecast]) -> Void = {(onlineForcast: [SevenDayForecast]) in
            self.weeklyForecast = onlineForcast
            //MARK: Zipcode completion: THIS IS WHERE THE NAME IS BEING SET
            let zipCodeToNameConversion: (String) -> Void = {(cityName: String) in
                self.keyWord = cityName
                self.weatherView.messageLabel.isHidden = false
                self.weatherView.messageLabel.text = "Weather forecast for \(self.keyWord)"
            }
            ZipCodeHelper.manager.getLocationName(from: self.keyWord,
                                                  completionHandler: zipCodeToNameConversion,
                                                  errorHandler: {print($0)})
        }
        WeatherAPIClient.manager.getForecast(usingZipCode: text,
                                             completion: loadForecastFromInternet,
                                             errorHandler: {print($0)})
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Alert Functions
extension WeatherViewController {
    func unknownZipCodeAlert(){
        let alertController = UIAlertController(title: "Unknown ZipCode",
                                                message:"ZipCode Not Found",
                                                preferredStyle: UIAlertControllerStyle.alert)
        let tryAnotherAction = UIAlertAction(title: "Try Another", style: UIAlertActionStyle.default)//for other actions add in actions incompletion{}
        alertController.addAction(tryAnotherAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func invalidZipCodeAlert(){
        let alertController = UIAlertController(title: "Invalid ZipCode",
                                                message:"Please enter a 5 digit ZipCode",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

