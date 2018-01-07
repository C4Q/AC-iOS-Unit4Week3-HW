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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(detailView)
        
        //setup dismiss buttons
        detailView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        //detailView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }

    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}
