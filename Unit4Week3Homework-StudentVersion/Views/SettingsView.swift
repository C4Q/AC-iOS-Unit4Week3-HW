//
//  SettingsView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Imperial", "Metric"])
        return sc
    }()
    
    private func setupSegmentedControl() {
        addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
            ])
    }
    
    lazy var zipCodeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.tintColor = .blue
        textField.placeholder = "Enter a zip code to save."
        return textField
    }()
    
    private func setupZipCodeTextField() {
        addSubview(zipCodeTextField)
        
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            zipCodeTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 25),
            zipCodeTextField.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor, constant: 0)
            ])
        
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupSegmentedControl()
        setupZipCodeTextField()
    }
    
}


