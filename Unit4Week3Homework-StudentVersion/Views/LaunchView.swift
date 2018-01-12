//
//  LaunchView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

protocol LaunchViewDelegate {
    func animationEnded()
}


class LaunchView: UIView {
    
    var delegate: LaunchViewDelegate?
    
    //Three labels
    
    lazy var byLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "By"
        return label
    }()
    
    lazy var weatherLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Design"
        return label
    }()
    
    lazy var stringLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "String"
        return label
    }()
    
    lazy var masterLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Masters"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .black
        setupAndConstrainObjects()
        setupViews()
    }
    
    private func setupAndConstrainObjects() {
        
        // ARRAY MUST BE ON ORDER
        let launchViewObjects = [byLabel, weatherLabel, stringLabel, masterLabel] as [UIView]
        
        launchViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            // By Label
            byLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            byLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 11),
            
            // Weather Label
            weatherLabel.bottomAnchor.constraint(equalTo: byLabel.topAnchor, constant: -5),
            weatherLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            // String Label
            stringLabel.topAnchor.constraint(equalTo: byLabel.bottomAnchor, constant: 5),
            stringLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            // Master Label
            masterLabel.topAnchor.constraint(equalTo: stringLabel.bottomAnchor, constant: 5),
            masterLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            
            ])
    }
    
    private func setupViews() {
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            
            self.weatherLabel.frame = self.weatherLabel.frame.offsetBy(dx: 0, dy: 200)
            self.byLabel.frame = self.byLabel.frame.offsetBy(dx: 0, dy: 200)
            self.stringLabel.frame = self.stringLabel.frame.offsetBy(dx: 0, dy: 200)
            self.masterLabel.frame = self.masterLabel.frame.offsetBy(dx: 0, dy: 200)
            
        }) { (success:Bool) in
            if success {
                //Fade the entire view out
                UIView.animate(withDuration: 3.0, animations: {
                    self.backgroundColor = .clear
                    self.weatherLabel.layer.opacity = 0
                    self.byLabel.layer.opacity = 0
                    self.stringLabel.layer.opacity = 0
                    self.masterLabel.layer.opacity = 0
                    
                }) {(success) in
                    self.delegate?.animationEnded()
                    //self.removeFromSuperview()
                }
            }
        }
    }
}
