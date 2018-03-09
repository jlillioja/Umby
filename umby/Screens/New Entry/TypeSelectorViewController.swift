//
//  TypeSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class TypeSelectorViewController: UmbyNewEntryViewController {
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("What type of entry is this?")
        view.addSubview(label)
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ]
        
        let typeTable = UmbyTable(self)
        view.addSubview(typeTable)
        let tableConstraints = [
            typeTable.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            typeTable.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            typeTable.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ]
        
        
        let customEntry = UmbyTextField(title: "Enter your own type", delegate: self)
        view.addSubview(customEntry)
        let customEntryConstraints = [
            customEntry.topAnchor.constraint(equalTo: typeTable.bottomAnchor, constant: margin),
            customEntry.heightAnchor.constraint(equalToConstant: 60),
            customEntry.leadingAnchor.constraint(equalTo: typeTable.leadingAnchor),
            customEntry.trailingAnchor.constraint(equalTo: typeTable.trailingAnchor),
        ]
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToFeelingSelector()
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

extension TypeSelectorViewController: UmbyTableViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagProvider?.tagsForType().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TagTableViewCell(tagProvider?.tagsForType()[indexPath.row] ?? "")
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

extension TypeSelectorViewController: UITextFieldDelegate {
    
}
