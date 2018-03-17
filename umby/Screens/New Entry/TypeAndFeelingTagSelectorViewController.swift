//
//  TypeSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class TypeAndFeelingTagSelectorViewController: UmbyNewEntryViewController {
    
    var typeTable: UmbyTable!
    var feelingTable: UmbyTable!
    
    var customTypeEntry: UmbyTextField!
    var customFeelingEntry: UmbyTextField!
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let typeLabel = UmbyLabel("TYPE")
        view.addSubview(typeLabel)
        [
            typeLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            typeLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
        ].activate()
        
        let feelingLabel = UmbyLabel("FEELING")
        view.addSubview(feelingLabel)
        [
            feelingLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: margin),
            feelingLabel.topAnchor.constraint(equalTo: typeLabel.topAnchor),
            feelingLabel.widthAnchor.constraint(equalTo: typeLabel.widthAnchor),
            feelingLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin)
        ].activate()
        
        typeTable = UmbyTable(self)
        view.addSubview(typeTable)
        [
            typeTable.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: margin),
            typeTable.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            typeTable.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
        ].activate()
        
        customTypeEntry = UmbyTextField(title: "Enter your own type", delegate: self)
        view.addSubview(customTypeEntry)
        [
            customTypeEntry.topAnchor.constraint(equalTo: typeTable.bottomAnchor, constant: margin),
            customTypeEntry.heightAnchor.constraint(equalToConstant: 60),
            customTypeEntry.leadingAnchor.constraint(equalTo: typeTable.leadingAnchor),
            customTypeEntry.trailingAnchor.constraint(equalTo: typeTable.trailingAnchor),
        ].activate()
        
        feelingTable = UmbyTable(self)
        view.addSubview(feelingTable)
        [
            feelingTable.topAnchor.constraint(equalTo: typeTable.topAnchor),
            feelingTable.leadingAnchor.constraint(equalTo: feelingLabel.leadingAnchor),
            feelingTable.trailingAnchor.constraint(equalTo: feelingLabel.trailingAnchor),
            feelingTable.bottomAnchor.constraint(equalTo: typeTable.bottomAnchor),
        ].activate()
        
        customFeelingEntry = UmbyTextField(title: "Enter your own feeling", delegate: self)
        view.addSubview(customFeelingEntry)
        [
            customFeelingEntry.topAnchor.constraint(equalTo: feelingTable.bottomAnchor, constant: margin),
            customFeelingEntry.heightAnchor.constraint(equalTo: customTypeEntry.heightAnchor),
            customFeelingEntry.leadingAnchor.constraint(equalTo: feelingTable.leadingAnchor),
            customFeelingEntry.trailingAnchor.constraint(equalTo: feelingTable.trailingAnchor),
        ].activate()
        
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToWhoAndWhereTagSelector()
        }
        view.addSubview(nextButton)
        bottomConstraint = nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        [
            nextButton.topAnchor.constraint(equalTo: customTypeEntry.bottomAnchor, constant: margin),
            nextButton.leadingAnchor.constraint(equalTo: customTypeEntry.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: customFeelingEntry.trailingAnchor),
            bottomConstraint!,
        ].activate()
    }
}

extension TypeAndFeelingTagSelectorViewController: UmbyTableViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == typeTable) {
            return tagProvider?.tags(for: .TYPE).count ?? 0
        } else {
            return tagProvider?.tags(for: .FEELING).count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == typeTable) {
            return TagTableViewCell(tagProvider?.tags(for: .TYPE)[indexPath.row])
        } else {
            return TagTableViewCell(tagProvider?.tags(for: .FEELING)[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? TagTableViewCell
        selectedCell?.accessoryType = .checkmark
        
        var tag: Tag?
        if let text = selectedCell?.tagText {
            if tableView == typeTable {
                tag = Tag(text: text, type: .TYPE)
            } else {
                tag = Tag(text: text, type:. FEELING)
            }
            newEntryBuilder?.addTag(tag!)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? TagTableViewCell
        selectedCell?.accessoryType = .none
        
        var tag: Tag?
        if let text = selectedCell?.tagText {
            if tableView == typeTable {
                tag = Tag(text: text, type: .TYPE)
            } else {
                tag = Tag(text: text, type:. FEELING)
            }
            newEntryBuilder?.removeTag(tag!)
        }
    }
}

extension TypeAndFeelingTagSelectorViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            if textField == customTypeEntry {
                newEntryBuilder?.removeCustomTag(Tag(text: text, type: .TYPE))
            } else {
                newEntryBuilder?.removeCustomTag(Tag(text: text, type: .FEELING))
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if textField == customTypeEntry {
                newEntryBuilder?.addCustomTag(Tag(text: text, type: .TYPE))
            } else {
                newEntryBuilder?.addCustomTag(Tag(text: text, type: .FEELING))
            }
        }
    }
}
