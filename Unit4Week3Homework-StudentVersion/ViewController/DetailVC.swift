//  DetailVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - Types
    
    // MARK: - Properties
    var pictures: PixabayResults? {
        didSet {
            dump(pictures)
        }
    }
    
    var weatherData: Period!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addNavBar()
        addSubviews()
        setupConstraints()
        PixabayModel.manager.fetchPictures(searchTerm: ZipCodeHelper.manager.viewLocationName(),
                                           completion: completionForPictures)
    }
    
    // MARK: - Inits
    init(weatherData: Period) {
        super.init(nibName: nil, bundle: nil)
        self.weatherData = weatherData
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    func setupConstraints() {
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        cityImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        cityImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        cityImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
    }
    
    // MARK: - Setup - View/Data
    lazy var cityImageView: UIImageView = {
        let iv = UIImageView()
        let activityIndicator = UIActivityIndicatorView.init(frame: iv.frame)
        activityIndicator.startAnimating()
        activityIndicator.center = iv.center
        self.view.addSubview(activityIndicator)
        activityIndicator.color = .green
        print(iv.subviews)
        return iv
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        let text = "High : " + weatherData.maxTempF.description + "°F"
        label.text = text
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        let text = "Low : " + weatherData.minTempF.description + "°F"
        label.text = text
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        let time = DateManager.shared.convertDateToTime(date: weatherData.sunriseISO)
        let text = "Sunrise: " + (time ?? "00.00")
        label.text = text
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        let time = DateManager.shared.convertDateToTime(date: weatherData.sunsetISO)
        let text = "Sunset: " + (time ?? "00.00")
        label.text = text
        return label
    }()
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        let text = "Day: " + weatherData.isDay.description
        label.text = text
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 15
        
        stack.addArrangedSubview(highLabel)
        stack.addArrangedSubview(lowLabel)
        stack.addArrangedSubview(sunriseLabel)
        stack.addArrangedSubview(sunsetLabel)
        stack.addArrangedSubview(dayLabel)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var completionForPictures: (PixabayResults) -> Void = { results in
        PixabayModel.manager.writeResults(results: results)
        guard let endpoint = PixabayModel.manager.fetchRandomPictureEndpoint() else {
            //Set placeholder image
            self.cityImageView.image = UIImage(named: "noImagePlaceholder")
            return
        }
        ImageDownloader.manager.getImage(from: endpoint,
                                         completionHandler: {self.cityImageView.image = UIImage(data: $0)},
                                         errorHandler: {print($0)})
    }
    
    // MARK: - User Actions
    @objc func savePicture() {
        let duplicateView = addDuplicateImageView(to: self.view)
        performAnimations(on: duplicateView)
        guard let imageToSave = cityImageView.image else { return }
        let dateAsString = Date().description + "." + ZipCodeHelper.manager.viewLocationName()
        let success = KeyedArchiverClient.shared.saveImageToDisk(image: imageToSave, artworkPath: dateAsString)
        if success {
            print(dateAsString)
            KeyedArchiverClient.shared.saveFavorites()
        }
        
    }
    
    // MARK: - Update Interface
    func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(cityImageView)
    }
    
    func addNavBar() {
        navigationItem.title = ZipCodeHelper.manager.viewLocationName()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePicture))
    }
    
    func addDuplicateImageView(to superView: UIView) -> UIView {
        let iv = UIImageView()
        iv.image = cityImageView.image
        superView.addSubview(iv)
        iv.frame = CGRect(x: 265, y: 261, width: 82, height: 73)
        let addedView = view.subviews.last!
        return addedView
    }

    func performAnimations(on view: UIView) {
        translateDuplicateImageDown(view)
        changeDuplicateImageOpacity(view)
    }
    
    func translateDuplicateImageDown(_ duplicateView: UIView) {
        let bottomOfImageView = duplicateView.frame.origin.y + duplicateView.frame.height
        let topOfTabBar = (tabBarController?.tabBar.frame.origin.y)!
        let distance = abs(bottomOfImageView - (topOfTabBar))
        guard let favTab = tabBarController?.tabBar.items?.last?.value(forKey: "view") as? UIView else { return }
        
        UIView.animate(withDuration: 1.5, animations: {
            duplicateView.transform = CGAffineTransform(translationX: 0, y: distance)
        }) { (success) in
            self.view.subviews.last?.removeFromSuperview()
            print("blah")
        }
    }
    
    func changeDuplicateImageOpacity(_ duplicateView: UIView) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        let customTimingFunction = CAMediaTimingFunction(controlPoints: 0.35, 0.6, 0.74, 0.9)
        opacityAnimation.timingFunction = customTimingFunction
        opacityAnimation.fromValue = 0.8
        opacityAnimation.toValue = 0.0
        opacityAnimation.duration = 2.0
        duplicateView.layer.add(opacityAnimation, forKey: nil)
    }
}
