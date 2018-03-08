//
//  TagSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class TagSelectorViewController: UmbyViewController {
    
    let whoEntries = ["Myself", "Parent", "Sibling", "Friend", "Boss", "Coworker", "Stranger", "Significant Other"]
    let whereEntries = ["Home", "Work", "Hotel", "Restaurant", "Public Transit", "Gym", "School", "Everywhere"]
    
    let whatTable = UmbyTable()
    let whoTable = UmbyTable()
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("What are you thinking?")
        view.addSubview(label)
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            ]
        
        whoTable.controller = self
        view.addSubview(whoTable)
        let whoTableConstraints = [
            whoTable.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            whoTable.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            ]
        
        whatTable.controller = self
        view.addSubview(whatTable)
        let whatTableConstraints = [
            whatTable.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            whatTable.leadingAnchor.constraint(equalTo: whoTable.trailingAnchor, constant: margin),
            whatTable.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            whatTable.bottomAnchor.constraint(equalTo: whoTable.bottomAnchor),
            whatTable.widthAnchor.constraint(equalTo: whoTable.widthAnchor)
        ]
        
        let customWhoEntry = UmbyTextField(title: "Enter your own", delegate: self)
        view.addSubview(customWhoEntry)
        let customWhoEntryConstraints = [
            customWhoEntry.topAnchor.constraint(equalTo: whoTable.bottomAnchor, constant: margin),
            customWhoEntry.heightAnchor.constraint(equalToConstant: 60),
            customWhoEntry.leadingAnchor.constraint(equalTo: whoTable.leadingAnchor),
            customWhoEntry.trailingAnchor.constraint(equalTo: whoTable.trailingAnchor),
            ]
        
        let customWhatEntry = UmbyTextField(title: "Enter your own", delegate: self)
        view.addSubview(customWhatEntry)
        let customWhatEntryConstraints = [
            customWhatEntry.topAnchor.constraint(equalTo: whatTable.bottomAnchor, constant: margin),
            customWhatEntry.heightAnchor.constraint(equalToConstant: 60),
            customWhatEntry.leadingAnchor.constraint(equalTo: whatTable.leadingAnchor),
            customWhatEntry.trailingAnchor.constraint(equalTo: whatTable.trailingAnchor),
            ]
        
        let nextButton = UmbyButton(title: "NEXT") {
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

extension TagSelectorViewController: UmbyTableViewController {
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

