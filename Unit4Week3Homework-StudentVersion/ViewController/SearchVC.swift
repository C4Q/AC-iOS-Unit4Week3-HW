//
//  SearchVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    var weatherData: Weather? {
        didSet {
            dump(weatherData)
            collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        return cv
    }()
    
    lazy var zipInputField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.borderStyle = .roundedRect
        tf.delegate = self
        tf.textColor = .white
        tf.textAlignment = .center
        return tf
    }()
    
    lazy var zipLabel: UILabel = {
        let label = UILabel()
        let text = "Enter a Zip Code"
        label.text = text
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        view.backgroundColor = .white
        setupViews()
        
    }
    
    func getForecast() {
        
        let zipCode = WeatherModel.manager.getZipCode()
        
        var endpoint = URLComponents(string: "https://api.aerisapi.com/forecasts/\(zipCode)")
        endpoint?.queryItems = [
            URLQueryItem(name: "client_id", value: "4TrQgLECYWUSFoL0EZIjL"),
            URLQueryItem(name: "client_secret", value: "QQzbq5bvl5pPR5DG81LkwyuNmdUK3kFzHnruexkA")
        ]
        
        guard let weatherEndpoint = endpoint?.url?.absoluteString else { return }
        
        ZipCodeHelper.manager.getLocationName(from: zipCode,
                                              completionHandler: {ZipCodeHelper.manager.setLocationName(name: $0);
                                                self.zipLabel.text = "Weather for \(ZipCodeHelper.manager.viewLocationName())"

        },
                                              errorHandler: {print($0)})
        
        WeatherAPIClient.manager.getForecast(from: weatherEndpoint,
                                             completionHandler: {self.weatherData = $0},
                                             errorHandler: {print($0)})
        
        
        
    }
    
    private func setupViews() {
        setupCollectionView()
        setupZipInputField()
        setupZipLabel()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    private func setupZipInputField() {
        view.addSubview(zipInputField)
        zipInputField.translatesAutoresizingMaskIntoConstraints = false
        zipInputField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30).isActive = true
        zipInputField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zipInputField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupZipLabel() {
        view.addSubview(zipLabel)
        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        zipLabel.topAnchor.constraint(equalTo: zipInputField.bottomAnchor, constant: 30).isActive = true
        zipLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

// MARK: Table View Data Source
extension SearchVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let weatherData = weatherData else { return 0 }
        if weatherData.success == false {
            collectionView.backgroundView = {
                let label = UILabel()
                label.center = collectionView.center
                label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 24)
                label.text = "No weather data found. 😎"
                label.textAlignment = .center
                return label
            }()
            return 0
        } else {
            collectionView.backgroundView = nil
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.response.first?.periods.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let index = indexPath.item
        let forecast = weatherData?.response.first?.periods[index]
        guard let dailyForecast = forecast else { return UICollectionViewCell() }
        cell.dateLabel.text = DateManager.shared.convertDateToString(date: dailyForecast.validTime)
        cell.highTempLabel.text = "Max Temp (F): " + dailyForecast.maxTempF.description
        cell.lowTempLabel.text = "Min Temp (F): " + dailyForecast.minTempF.description
        
        cell.imageView.image = UIImage(named: dailyForecast.icon)
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

extension SearchVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let digitsInField = range.location
        if string == "" { return true }
        guard let _ = Int(string) else { return false }
        guard digitsInField < 5 else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text?.count == 5 else { return false }
        guard let zipCode = textField.text else { return false }
        if zipCode == "00000" {
            return false
        }
        WeatherModel.manager.setZipCode(zip: zipCode)
        getForecast()
        return true
    }
    
    
}
