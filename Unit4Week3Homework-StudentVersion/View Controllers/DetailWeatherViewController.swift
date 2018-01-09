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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(detailView)
        
        //setup buttons
        detailView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        detailView.exitButton.addTarget(self, action: #selector(dismissViewWithButton), for: .touchUpInside)
        detailView.saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    //TODO: - add button action to dismiss view
    @objc func dismissViewWithButton() {
        //dismiss(animated: true, completion: nil)
    }
    //TODO: - save button action
    @objc func saveImage() {
        //dismiss(animated: true, completion: nil)
        //TODO: - creat alert letting user know they have saves OR create animation that shows image going to favorites VC
    }
    
}

