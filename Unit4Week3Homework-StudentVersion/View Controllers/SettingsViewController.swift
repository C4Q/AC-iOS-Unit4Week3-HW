//
//  SettingsViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(settingsView)
        
        if let myDefaults = UserDefaultsHelper.manager.getValue() {
            settingsView.segmentedControl.selectedSegmentIndex = myDefaults.measurementSystem
            settingsView.zipCodeTextField.text = myDefaults.zipCode.description
        }
        
        settingsView.segmentedControl.addTarget(self, action: #selector(segmentedControlTapped), for: .valueChanged)
        
    }
    
    @objc func segmentedControlTapped() {
        
        let myDefault = UserDefaultsHelper.MyDefaults(zipCode: Int(settingsView.zipCodeTextField.text!)!, measurementSystem: self.settingsView.segmentedControl.selectedSegmentIndex)
        
        UserDefaultsHelper.manager.createDefaultSetting(value: myDefault)
        
        
    }
    

}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else { textField.resignFirstResponder(); return false }
        guard let zip = Int(text), text.count == 5 else { textField.resignFirstResponder(); alertController(title: "Invalid Input", message: "Please enter a valid zip code."); return false }
        
        let myDefault = UserDefaultsHelper.MyDefaults(zipCode: zip, measurementSystem: self.settingsView.segmentedControl.selectedSegmentIndex)
        
        UserDefaultsHelper.manager.createDefaultSetting(value: myDefault)
        
        textField.resignFirstResponder();
        return true
    }
    
    func alertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
}

