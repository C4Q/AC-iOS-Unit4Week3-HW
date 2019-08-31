//
//  ViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let searchView = CustomSearchView()
    let cellSpacing: CGFloat = 8.0
    var zipCode: String! {
        didSet {
            if zipCode != "" {
            UserDefaults.standard.setValue(zipCode, forKeyPath: "zipCode")
            }
          loadWeathers(from: zipCode)
        }
    }
    var weathers = [DayWeather]() {
        didSet {
            searchView.collectionView.reloadData()
        }
    }
    var city = "" {
        didSet {
            searchView.titleLabel.text = "Weather forcast for \(city)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search"
        self.view.backgroundColor = .white
        self.title = "Search"
        view.addSubview(searchView)
        searchView.backgroundColor = .white
        setupSearchView()
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        
        self.zipCode = UserDefaults.standard.value(forKeyPath: "zipCode") as? String ?? ""
        searchView.textField.delegate = self
    }


    func setupSearchView() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func loadWeathers(from zipCode: String) {
        let completion: (InfoDict) -> Void = {(onlineInfo: InfoDict) in
            self.weathers = onlineInfo.periods
            let onlineCity = onlineInfo.profile.tz.components(separatedBy: "/")[1]
            self.city = onlineCity.replacingOccurrences(of: "_", with: " ")
        }
        WeatherAPIClient.manager.getWeather(from: zipCode, completionHandler: completion, errorHandler: {print($0)})
    }


}
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else {return false}
        self.zipCode = textField.text!
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if "".contains(string) {
            return true
        }
        if !"1234567890".contains(string) {
            return false
        }
       
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
   
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.init(red: 0.49, green: 0.75, blue: 0.91, alpha: 1)
        let date = weathers[indexPath.row].validTime.components(separatedBy: "T")[0]
        cell.dateLabel.text = date
        let highTemp = weathers[indexPath.row].maxTempF
        let lowTemp = weathers[indexPath.row].minTempF
        cell.highLabel.text = "High: \(highTemp)℉"
        cell.lowLabel.text = "High: \(lowTemp)℉"
        let icon = weathers[indexPath.row].icon
        cell.imageView.image = UIImage(named: icon)
        
        return cell
    }
}


extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = DetailViewController()
        self.navigationController?.pushViewController(destination, animated: true)
        destination.city = self.city
        destination.weather = weathers[indexPath.row]
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}






