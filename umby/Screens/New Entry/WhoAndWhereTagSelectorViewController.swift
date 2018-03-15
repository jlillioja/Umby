//
//  TagSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class WhoAndWhereTagSelectorViewController: UmbyNewEntryViewController {
    
    let whoEntries = ["Myself", "Parent", "Sibling", "Friend", "Boss", "Coworker", "Stranger", "Significant Other"]
    let whereEntries = ["Home", "Work", "Hotel", "Restaurant", "Public Transit", "Gym", "School", "Everywhere"]
    
    let whereTable = UmbyTable()
    let whoTable = UmbyTable()
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("What are you thinking?")
        view.addSubview(label)
        [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        let whoLabel = UmbyLabel("WHO")
        view.addSubview(whoLabel)
        [
            whoLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            whoLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
        ].activate()
        
        let whereLabel = UmbyLabel("WHERE")
        view.addSubview(whereLabel)
        [
            whereLabel.topAnchor.constraint(equalTo: whoLabel.topAnchor),
            whereLabel.bottomAnchor.constraint(equalTo: whoLabel.bottomAnchor),
            whereLabel.leadingAnchor.constraint(equalTo: whoLabel.trailingAnchor, constant: margin),
            whereLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            whereLabel.widthAnchor.constraint(equalTo: whoLabel.widthAnchor),
        ].activate()
        
        whoTable.controller = self
        view.addSubview(whoTable)
        [
            whoTable.topAnchor.constraint(equalTo: whoLabel.bottomAnchor, constant: margin),
            whoTable.leadingAnchor.constraint(equalTo: whoLabel.leadingAnchor),
            whoTable.trailingAnchor.constraint(equalTo: whoLabel.trailingAnchor),
        ].activate()
        
        whereTable.controller = self
        view.addSubview(whereTable)
        [
            whereTable.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: margin),
            whereTable.leadingAnchor.constraint(equalTo: whereLabel.leadingAnchor),
            whereTable.trailingAnchor.constraint(equalTo: whereLabel.trailingAnchor),
            whereTable.bottomAnchor.constraint(equalTo: whoTable.bottomAnchor),
        ].activate()
        
        let customWhoEntry = UmbyTextField(title: "Enter your own", delegate: self)
        view.addSubview(customWhoEntry)
        [
            customWhoEntry.topAnchor.constraint(equalTo: whoTable.bottomAnchor, constant: margin),
            customWhoEntry.heightAnchor.constraint(equalToConstant: 60),
            customWhoEntry.leadingAnchor.constraint(equalTo: whoTable.leadingAnchor),
            customWhoEntry.trailingAnchor.constraint(equalTo: whoTable.trailingAnchor),
        ].activate()
        
        let customWhatEntry = UmbyTextField(title: "Enter your own", delegate: self)
        view.addSubview(customWhatEntry)
        [
            customWhatEntry.topAnchor.constraint(equalTo: whereTable.bottomAnchor, constant: margin),
            customWhatEntry.heightAnchor.constraint(equalToConstant: 60),
            customWhatEntry.leadingAnchor.constraint(equalTo: whereTable.leadingAnchor),
            customWhatEntry.trailingAnchor.constraint(equalTo: whereTable.trailingAnchor),
        ].activate()
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToConsiderationSelector()
        }
        view.addSubview(nextButton)
        bottomConstraint = nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        [
            nextButton.topAnchor.constraint(equalTo: customWhoEntry.bottomAnchor, constant: margin),
            nextButton.topAnchor.constraint(equalTo: customWhatEntry.bottomAnchor, constant: margin),
            nextButton.leadingAnchor.constraint(equalTo: customWhoEntry.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: customWhatEntry.trailingAnchor),
            bottomConstraint!,
        ].activate()
    }
}

extension WhoAndWhereTagSelectorViewController: UmbyTableViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == whoTable) {
            return tagProvider?.tagsForWho().count ?? 0
        } else {
            return tagProvider?.tagsForWhere().count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == whoTable) {
            return TagTableViewCell(tagProvider?.tagsForWho()[indexPath.row] ?? "")
        } else {
            return TagTableViewCell(tagProvider?.tagsForWhere()[indexPath.row] ?? "")
        }
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

extension WhoAndWhereTagSelectorViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            newEntryBuilder?.removeTag(text)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            newEntryBuilder?.addTag(text)
        }
    }
}
