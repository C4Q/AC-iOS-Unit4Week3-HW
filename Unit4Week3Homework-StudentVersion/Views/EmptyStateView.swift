//
//  EmptyStateView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 3/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "No favorite city images yet!"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = UIColor(displayP3Red: 167/255, green: 173/255, blue: 183/255, alpha: 1.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit() {
        backgroundColor = UIColor(displayP3Red: 239/255, green: 242/255, blue: 247/255, alpha: 1.0)
        setupViews()
    }
    private func setupViews() {
        //Remember that you need to call EVERY FUNCTION that deals with setting up the view
        setupDismissView()
        setupAndConstrainObjects()
    }
    private func setupDismissView() {
        addSubview(emptyStateLabel)
    }
    
    private func setupAndConstrainObjects() {
        //ARRAY MUST BE ON ORDER!!
        let allDetailViewObjects = [emptyStateLabel] as [UIView]
        
        allDetailViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            //emptyStateLabel
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            emptyStateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
    }
}
