//
//  DetailWeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {

    let detailView = DetailView()
    
    //For saving the image to the phone
    var imageURLtoSave = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(detailView)
        
        //setup dismiss buttons
        detailView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        detailView.exitButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        detailView.saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
    }

    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveImage() {
        FileManagerHelper.manager.addFavoriteImage(from: imageURLtoSave)
        print("Save Button clicked")
    }
    
    
    // TODO: Add animation for save button being clicked

}
