//
//  TagSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class TagSelectorViewController: UIViewController {
    
    var navigationManager: NavigationManager?
    let margin: CGFloat = 30.0
    
    let whoEntries = ["Myself", "Parent", "Sibling", "Friend", "Boss", "Coworker", "Stranger", "Significant Other"]
    let whereEntries = ["Home", "Work", "Hotel", "Restaurant", "Public Transit", "Gym", "School", "Everywhere"]
    
    let whatTable = UITableView().forCustom()
    let whoTable = UITableView().forCustom()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UmbyColors.blue
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UILabel().forCustom()
        label.text = "What are you thinking ?"
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
        
        whoTable.delegate = self
        whoTable.dataSource = self
        whoTable.layer.cornerRadius = UmbyStyle.smallCornerRadius
        whoTable.separatorStyle = .none
        view.addSubview(whoTable)
        let whoTableConstraints = [
            whoTable.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            whoTable.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
        ]
        
        whatTable.delegate = self
        whatTable.dataSource = self
        whatTable.layer.cornerRadius = UmbyStyle.smallCornerRadius
        whatTable.separatorStyle = .none
        view.addSubview(whatTable)
        let whatTableConstraints = [
            whatTable.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            whatTable.leadingAnchor.constraint(equalTo: whoTable.trailingAnchor, constant: margin),
            whatTable.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            whatTable.bottomAnchor.constraint(equalTo: whoTable.bottomAnchor),
            whatTable.widthAnchor.constraint(equalTo: whoTable.widthAnchor)
        ]
        
        let customWhoEntry = UITextField().forCustom()
        customWhoEntry.delegate = self
        customWhoEntry.borderStyle = .roundedRect
        let whoAttributedPlaceholder = NSAttributedString(string: "Enter your own", attributes: [
            NSAttributedStringKey.foregroundColor: UmbyColors.grey
            ])
        customWhoEntry.attributedPlaceholder = whoAttributedPlaceholder
        customWhoEntry.backgroundColor = UmbyColors.white
        customWhoEntry.layer.cornerRadius = UmbyStyle.smallCornerRadius
        view.addSubview(customWhoEntry)
        let customWhoEntryConstraints = [
            customWhoEntry.topAnchor.constraint(equalTo: whoTable.bottomAnchor, constant: margin),
            customWhoEntry.heightAnchor.constraint(equalToConstant: 60),
            customWhoEntry.leadingAnchor.constraint(equalTo: whoTable.leadingAnchor),
            customWhoEntry.trailingAnchor.constraint(equalTo: whoTable.trailingAnchor),
        ]
        
        let customWhatEntry = UITextField().forCustom()
        customWhatEntry.delegate = self
        customWhatEntry.borderStyle = .roundedRect
        let whereAttributedPlaceholder = NSAttributedString(string: "Enter your own", attributes: [
            NSAttributedStringKey.foregroundColor: UmbyColors.grey
            ])
        customWhatEntry.attributedPlaceholder = whereAttributedPlaceholder
        customWhatEntry.backgroundColor = UmbyColors.white
        customWhatEntry.layer.cornerRadius = UmbyStyle.smallCornerRadius
        view.addSubview(customWhatEntry)
        let customWhatEntryConstraints = [
            customWhatEntry.topAnchor.constraint(equalTo: whatTable.bottomAnchor, constant: margin),
            customWhatEntry.heightAnchor.constraint(equalToConstant: 60),
            customWhatEntry.leadingAnchor.constraint(equalTo: whatTable.leadingAnchor),
            customWhatEntry.trailingAnchor.constraint(equalTo: whatTable.trailingAnchor),
        ]
        
        let nextButton = UIButton().forCustom()
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.backgroundColor = UmbyColors.white
        nextButton.layer.cornerRadius = UmbyStyle.smallCornerRadius
        nextButton.setTitleColor(UmbyColors.blue, for: .normal)
        nextButton.onTap {
            self.navigationManager?.navigateToConsiderationSelector()
        }
        view.addSubview(nextButton)
        let nextButtonConstraints = [
            nextButton.topAnchor.constraint(equalTo: customWhoEntry.bottomAnchor, constant: margin),
            nextButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            nextButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        ]
        
        NSLayoutConstraint.activate(labelConstraints+whoTableConstraints+whatTableConstraints+customWhoEntryConstraints+customWhatEntryConstraints+nextButtonConstraints)
    }
}

extension TagSelectorViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == whoTable) {
            return whoEntries.count
        } else {
            return whereEntries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == whoTable) {
            return TypeTableViewCell(whoEntries[indexPath.row])
        } else {
            return TypeTableViewCell(whereEntries[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TagSelectorViewController: UITextFieldDelegate {
    
}

