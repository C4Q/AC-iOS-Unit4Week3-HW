//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    let sampleArray = [1,2,3,4,5,6] //for testing ONLY
    
    let weatherView = WeatherView()
    
    let cellSpacing: CGFloat =  10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = "7 Day Forecast"
        
        //CV Delegates
        view.addSubview(weatherView)
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.textField.delegate = self
        loadForecast()
        
        //loading most recent zipcode from user defaults
        if let savedZipcode = UserDefaultsHelper.manager.getZipcode() {
            weatherView.textField.text = String(savedZipcode)
            print("zipcode loaded from UD")
        } else {
            weatherView.textField.text = ""
        }
    }
    
    func loadForecast(){
        
        setUpAutomaticScrolling()
    }
    
    
    //MARK: - Adding scrolling animation when the user draws another card: https://stackoverflow.com/questions/15985574/uicollectionview-auto-scroll-to-cell-at-indexpath
    func setUpAutomaticScrolling(){
        //set last index to be the last card in the array
        let lastIndex = self.sampleArray.count - 1
        //make sure that the last Index is not negative or else you will crash
        guard lastIndex >= 0 else {return}
        //creates an indexpath based on the lastIndex and whatever section you are referencing
        let indexPathOfDay = IndexPath(item: lastIndex, section: 0)
        //set scrolling animation
        weatherView.collectionView.scrollToItem(at: indexPathOfDay, at: .right, animated: true)
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        cell.backgroundColor = .white
        return cell
    }
}
extension WeatherViewController: UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // using dependency injection to pass Fellow Model Object to DetailVC
        let detailWVC = DetailWeatherViewController()
        
        detailWVC.modalTransitionStyle = .crossDissolve
        detailWVC.modalPresentationStyle = .overCurrentContext
        present(detailWVC, animated: true, completion: nil)
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //handling for numbers only
        let allowedCharacters = CharacterSet.decimalDigits //digits ONLY
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {return true}
        
        let bounds = weatherView.textField.bounds
        
        if text.count < 5{
            textField.text = ""
            textField.placeholder = "e.g. 12345"
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                self.weatherView.textField.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            }) { (success:Bool) in
                if success {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.weatherView.textField.bounds = bounds
                    })
                    
                }
            }
            
        } else if let textFieldAsInt = Int(text) {
            //calling userDefaults to save zipcode entered
            UserDefaultsHelper.manager.setZipcode(to: textFieldAsInt)
            print("\(textFieldAsInt) zipcode was saved!")
        }
        //make Weather API call: reload collection View as part of the completion handler in the weather API call
        textField.resignFirstResponder()
        return true
    }
    
    
}
