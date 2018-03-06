//
//  TypeSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class TypeSelectorViewController: UIViewController {
    
    var navigationManager: NavigationManager?
    let margin: CGFloat = 30.0
    
    let typeEntries = ["Idea", "Complaint", "Vision/Dream", "Worry", "Problem", "General Thought"]
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UmbyColors.blue
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UILabel().forCustom()
        label.text = "What type of entry is this?"
        label.textColor = UmbyColors.white
        label.font = .systemFont(ofSize: 16.0)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textAlignment = .center
        view.addSubview(label)
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
        ]
        
        let typeTable = UITableView().forCustom()
        typeTable.delegate = self
        typeTable.dataSource = self
        typeTable.layer.cornerRadius = UmbyStyle.smallCornerRadius
        typeTable.separatorStyle = .none
        
        view.addSubview(typeTable)
        let tableConstraints = [
            typeTable.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            typeTable.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            typeTable.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ]
        
        
        let customEntry = UITextField().forCustom()
        customEntry.delegate = self
        customEntry.borderStyle = .roundedRect
        let attributedPlaceholder = NSAttributedString(string: "Enter your own type", attributes: [
            NSAttributedStringKey.foregroundColor: UmbyColors.grey
        ])
        customEntry.attributedPlaceholder = attributedPlaceholder
        customEntry.backgroundColor = UmbyColors.white
        customEntry.layer.cornerRadius = UmbyStyle.smallCornerRadius
        view.addSubview(customEntry)
        let customEntryConstraints = [
            customEntry.topAnchor.constraint(equalTo: typeTable.bottomAnchor, constant: margin),
            customEntry.heightAnchor.constraint(equalToConstant: 60),
            customEntry.leadingAnchor.constraint(equalTo: typeTable.leadingAnchor),
            customEntry.trailingAnchor.constraint(equalTo: typeTable.trailingAnchor),
        ]
        
        let nextButton = UIButton().forCustom()
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.backgroundColor = UmbyColors.white
        nextButton.layer.cornerRadius = UmbyStyle.smallCornerRadius
        nextButton.setTitleColor(UmbyColors.blue, for: .normal)
        nextButton.onTap {
            self.navigationManager?.navigateToFeelingSelector()
        }
        view.addSubview(nextButton)
        let nextButtonConstraints = [
            nextButton.topAnchor.constraint(equalTo: customEntry.bottomAnchor, constant: margin),
            nextButton.leadingAnchor.constraint(equalTo: customEntry.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: customEntry.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        ]
        
        NSLayoutConstraint.activate(labelConstraints+tableConstraints+customEntryConstraints+nextButtonConstraints)
    }
}

extension TypeSelectorViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TypeTableViewCell(typeEntries[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TypeSelectorViewController: UITextFieldDelegate {
    
}
