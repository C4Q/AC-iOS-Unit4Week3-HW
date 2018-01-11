//  DetailVC.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - Properties
    var endpointOfRandomPicture = String()
    var weatherData: Period!
    
    var pictures: PixabayResults?
    
    let detailView = DetailView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
    private func setupViews() {
        setupController()
        setupNavBar()
    }
    
    private func setupController() {
        view.backgroundColor = .white
        view.addSubview(detailView)
    }
    
    private func setupNavBar() {
        navigationItem.title = ZipCodeHelper.manager.viewLocationName()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
    }
    
    
    // MARK: - Setup - View/Data
    lazy var completionForPictures: (PixabayResults) -> Void = { results in
        PixabayModel.manager.writeResults(results: results)
        guard let endpoint = PixabayModel.manager.fetchRandomPictureEndpoint() else {
            //Set placeholder image
            self.detailView.cityImageView.image = UIImage(named: "noImagePlaceholder")
            return
        }
        self.endpointOfRandomPicture = PixabayModel.manager.uniqueStringFromEndpoint(endpoint)
        ImageDownloader.manager.getImage(from: endpoint,
                                         completionHandler: {self.detailView.cityImageView.image = UIImage(data: $0);
                                            self.detailView.activity.stopAnimating()},
                                         errorHandler: {print($0)})
    }
    
    // MARK: - User Actions
    @objc func saveButtonPressed() {
        savePicture()
    }
    
    func savePicture() {
        guard let imageToSave = detailView.cityImageView.image else { return }
        let savedImageName = endpointOfRandomPicture + "." + ZipCodeHelper.manager.viewLocationName()
        let imageIsAlreadySaved = KeyedArchiverClient.shared.fetchListOfImages().contains(savedImageName)
        
        guard !imageIsAlreadySaved else {
            print("Image already saved!")
            return
        }
        
        let duplicateView = addDuplicateImageView(to: self.view)
        performAnimations(on: duplicateView)
        
        let success = KeyedArchiverClient.shared.saveImageToDisk(image: imageToSave, artworkPath: savedImageName)
        if success {
            KeyedArchiverClient.shared.saveFavorites()
        }
        
    }
    
    // MARK: - Update Interface
    func addDuplicateImageView(to superView: UIView) -> UIView {
        let iv = UIImageView()
        iv.image = detailView.cityImageView.image
        iv.frame = CGRect(x: 265, y: 261, width: 82, height: 73)
        superView.addSubview(iv)
        return iv
    }
    
    // MARK: - Animations
    func performAnimations(on view: UIView) {
        translateDuplicateImageDown(view)
        changeDuplicateImageOpacity(view)
    }
    
    func translateDuplicateImageDown(_ duplicateView: UIView) {
        let bottomOfImageView = duplicateView.frame.origin.y + duplicateView.frame.height
        let topOfTabBar = (tabBarController?.tabBar.frame.origin.y)!
        let distance = abs(bottomOfImageView - (topOfTabBar))
        
        UIView.animate(withDuration: 1.5, animations: {
            duplicateView.transform = CGAffineTransform(translationX: 0, y: distance)
        }) { (success) in
            self.view.subviews.last?.removeFromSuperview()
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
