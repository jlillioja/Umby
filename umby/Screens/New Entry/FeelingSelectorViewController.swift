//
//  FeelingSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class FeelingSelectorViewController: UmbyNewEntryViewController {
    
    let feelingEntries = ["Calm", "Angry", "Prepared", "Unprepared", "Happy", "Sad", "Confident", "Afraid", "Proud", "Embarrassed" ]
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("What are you feeling?")
        view.addSubview(label)
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            ]
        
        let feelingTable = UmbyTable(self)
        view.addSubview(feelingTable)
        let tableConstraints = [
            feelingTable.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            feelingTable.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            feelingTable.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            ]
        
        
        let customEntry = UmbyTextField(title: "Enter my own feeling", delegate: self)
        view.addSubview(customEntry)
        let customEntryConstraints = [
            customEntry.topAnchor.constraint(equalTo: feelingTable.bottomAnchor, constant: margin),
            customEntry.heightAnchor.constraint(equalToConstant: 60),
            customEntry.leadingAnchor.constraint(equalTo: feelingTable.leadingAnchor),
            customEntry.trailingAnchor.constraint(equalTo: feelingTable.trailingAnchor),
        ]
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToTagSelector()
        }
        view.addSubview(nextButton)
        bottomConstraint = nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        let nextButtonConstraints = [
            nextButton.topAnchor.constraint(equalTo: customEntry.bottomAnchor, constant: margin),
            nextButton.leadingAnchor.constraint(equalTo: customEntry.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: customEntry.trailingAnchor),
            bottomConstraint!,
        ]
        
        NSLayoutConstraint.activate(labelConstraints+tableConstraints+customEntryConstraints+nextButtonConstraints)
    }
}

extension FeelingSelectorViewController: UmbyTableViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagProvider?.tagsForFeelings().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TagTableViewCell(tagProvider?.tagsForFeelings()[indexPath.row] ?? "")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? TagTableViewCell
        selectedCell?.accessoryType = .checkmark
        newEntryBuilder?.addTag(selectedCell?.tagText)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? TagTableViewCell
        selectedCell?.accessoryType = .none
        newEntryBuilder?.removeTag(selectedCell?.tagText)
    }
}

extension FeelingSelectorViewController: UITextFieldDelegate {
    
}
