//
//  SearchVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit


class SearchVC: UIViewController {
    
    // MARK: - Views
    let searchView = SearchView() 
    
    // MARK: - Properties
    var weatherData: Weather? {
        didSet {
            if let temp = weatherData?.response.first?.periods.first?.maxTempF {
                searchView.setBackgroundImage(temp: temp)
            }
            searchView.collectionView.reloadData()
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
//        navigationController?.navigationBar.barTintColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 0)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "cloudyBanner"), for: .default)
        
        
        setupSearchView()
        getForecast()
    }
    
    private func setupSearchView() {
        view.addSubview(searchView)
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.zipInputField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    // MARK: - User Actions
    @objc func keyboardShown(notification: NSNotification) {
        if let infokey = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] {
            let frame = (infokey as! AnyObject).cgRectValue
            let keyboardFrame = view.convert(frame!, from: nil)
            print(keyboardFrame)
        }
    }

    private func getForecast() {
        let savedZip = UserDefaultManager.shared.fetchDefaultZip(key: UserDefaultManager.shared.userDefaultKey)
        
        guard let zipCode = savedZip ?? WeatherModel.manager.getZipCode()  else { return }
        guard let weatherEndpoint = WeatherModel.manager.weatherEndpointFromZipCode(zipCode) else { return }
        
        print("Running api")
        ZipCodeHelper.manager.getLocationName(from: zipCode,
                                              completionHandler: { ZipCodeHelper.manager.setLocationName(name: $0);
                                                self.searchView.setLocationLabel() },
                                              errorHandler: {print($0)})
        
        WeatherAPIClient.manager.getForecast(from: weatherEndpoint,
                                             completionHandler: {self.weatherData = $0},
                                             errorHandler: {print($0)})
    }

}

// MARK: Table View Data Source
extension SearchVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let weatherData = weatherData else { return 0 }
        if weatherData.success == false {
            searchView.collectionView.backgroundView = searchView.backgroundView
            return 0
        } else {
            searchView.collectionView.backgroundView = nil
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.response.first?.periods.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let forecast = weatherData?.response.first?.periods[indexPath.item]
        guard let dailyForecast = forecast else { return UICollectionViewCell() }
        cell.configureCell(dailyForecast)
        return cell
    }
    
}

// MARK: Table View Delegate
extension SearchVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        guard let selectedForecast = weatherData?.response.first?.periods[index] else { return }
        let detailVC = DetailVC(weatherData: selectedForecast)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

// MARK: Text Field Delegate
extension SearchVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let digitsInField = range.location
        if string == "" { return true }
        guard let _ = Int(string) else { return false }
        guard digitsInField < 5 else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        guard textField.text?.count == 5 else { return false }
        guard let zipCode = textField.text else { return false }
        if zipCode == "00000" {
            return false
        }
        textFieldDidReturn(zipCode: zipCode)
        return true
    }
    
    func textFieldDidReturn(zipCode: String) {
        WeatherModel.manager.setZipCode(zip: zipCode)
        UserDefaultManager.shared.setDefaultZip(value: zipCode, key: UserDefaultManager.shared.userDefaultKey)
        getForecast()
    }
    
}
