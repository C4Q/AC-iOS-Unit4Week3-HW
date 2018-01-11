//
//  DetailWeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//


import UIKit

class DetailWeatherViewController: UIViewController {
    
    let detailView = DetailView()
    
    var detailCityImage = ""
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(detailView)
        
        //setup buttons
        detailView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        detailView.exitButton.addTarget(self, action: #selector(dismissViewWithButton), for: .touchUpInside)
        detailView.saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
    }
    
    
    //MARK: - button functionality
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func dismissViewWithButton() {
        dismiss(animated: true, completion: nil)
    }
    
    //TODO: - save button action
    @objc func saveImage() {
        //just saving string of url
        FileManagerHelper.manager.addFavoriteImageToFileManager(from: detailCityImage)
        print("Saved image url to file manager")
        //TODO: - create alert

    }
}

