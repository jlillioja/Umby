//
//  EntryListViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/7/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class EntryListViewController: UmbyViewController {
    
    open var tableTitle: String {
        get {
            return "Notes"
        }
    }
    
    var entryProvider: EntryProvider?
    func entries() -> [Entry] {
        return entryProvider?.getEntries(satisfying: { _ in return true }) ?? []
    }
    
    var tagProvider: TagProvider!
    
    var entryList: UmbyTable! = nil
    var filterWithAllSwitch: UISwitch! = nil
    
    var filterButton: UmbyButton! = nil
    let defaultFilterButtonTitle = "Filter by Tag"
    
    var tagFilterList: [Tag] = []
    var searchFilterList: [String] = []
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UmbyColors.white
        let layoutGuide = view.safeAreaLayoutGuide
        
        let titleLabel = UmbyLabel(tableTitle).textColor(UmbyColors.blue)
        view.addSubview(titleLabel)
        [
            titleLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            titleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin)
        ].activate()
        
        let searchBar = UmbyTextField(title: "Search notes", delegate: self)
        searchBar.clearButtonMode = .always
        searchBar.returnKeyType = .search
        view.addSubview(searchBar)
        [
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            searchBar.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            searchBar.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin)
        ].activate()


        filterButton = UmbyButton(title: defaultFilterButtonTitle)
        view.addSubview(filterButton)
        [
            filterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: margin),
            filterButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            filterButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        entryList = UmbyTable(self)
        view.addSubview(entryList)
        entryList.backgroundColor = UmbyColors.blue
        [
            entryList.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: margin),
            entryList.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            entryList.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            entryList.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin),
        ].activate()
        
        let filterDropdown = UIView().forCustom()
        filterDropdown.layer.cornerRadius = 5
//        filterDropdown.axis = .vertical
//        filterDropdown.alignment = .center
        view.addSubview(filterDropdown)
        filterDropdown.isHidden = true
        filterDropdown.backgroundColor = UIColor.white
        [
            filterDropdown.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            filterDropdown.leadingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: margin),
            filterDropdown.trailingAnchor.constraint(equalTo: filterButton.trailingAnchor, constant: -margin),
            filterDropdown.heightAnchor.constraint(equalToConstant: 300)
        ].activate()
        
//        let switchContainer = UIStackView.init().forCustom()
//        switchContainer.axis = .horizontal
//        switchContainer.alignment = .center
//        filterDropdown.addSubview(switchContainer)
//        [
//            switchContainer.topAnchor.constraint(equalTo: filterDropdown.topAnchor),
//            switchContainer.leadingAnchor.constraint(equalTo: filterDropdown.leadingAnchor),
//            switchContainer.trailingAnchor.constraint(equalTo: filterDropdown.trailingAnchor)
//        ].activate()
        
        filterWithAllSwitch = UISwitch().forCustom()
        filterWithAllSwitch.setContentCompressionResistancePriority(.required, for: .vertical)
        filterDropdown.addSubview(filterWithAllSwitch)
        filterWithAllSwitch.addTarget(self, action: #selector(resetSearchFilter), for: UIControlEvents.valueChanged)
        [
            filterWithAllSwitch.topAnchor.constraint(equalTo: filterDropdown.topAnchor),
            filterWithAllSwitch.centerXAnchor.constraint(equalTo: filterDropdown.centerXAnchor)
        ].activate()
        
        let anyLabel = UmbyLabel("With Any").small().textColor(UmbyColors.darkBlue)
        anyLabel.textAlignment = .center
        filterDropdown.addSubview(anyLabel)
        [
            anyLabel.leadingAnchor.constraint(equalTo: filterDropdown.leadingAnchor),
            anyLabel.trailingAnchor.constraint(equalTo: filterWithAllSwitch.leadingAnchor),
            anyLabel.topAnchor.constraint(equalTo: filterWithAllSwitch.topAnchor),
            anyLabel.bottomAnchor.constraint(equalTo: filterWithAllSwitch.bottomAnchor)
        ].activate()
        
        let allLabel = UmbyLabel("With All").small().textColor(UmbyColors.darkBlue)
        allLabel.textAlignment = .center
        filterDropdown.addSubview(allLabel)
        [
            allLabel.leadingAnchor.constraint(equalTo: filterWithAllSwitch.trailingAnchor),
            allLabel.topAnchor.constraint(equalTo: filterWithAllSwitch.topAnchor),
            allLabel.bottomAnchor.constraint(equalTo: filterWithAllSwitch.bottomAnchor),
            allLabel.trailingAnchor.constraint(equalTo: filterDropdown.trailingAnchor)
        ].activate()
        
        let filterTable = UmbyTable(self)
        filterDropdown.addSubview(filterTable)
        [
            filterTable.topAnchor.constraint(equalTo: filterWithAllSwitch.bottomAnchor, constant: 5),
            filterTable.leadingAnchor.constraint(equalTo: filterDropdown.leadingAnchor),
            filterTable.trailingAnchor.constraint(equalTo: filterDropdown.trailingAnchor),
            filterTable.bottomAnchor.constraint(equalTo: filterDropdown.bottomAnchor)
        ].activate()
        
        filterButton.onTap {
            filterDropdown.isHidden = !filterDropdown.isHidden
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        entryList.reloadData()
    }
    
    @objc func resetSearchFilter() {
        entryList.reloadData()
    }
}

extension EntryListViewController: UmbyTableViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == entryList) {
            return entries().count
        } else {
            return tagProvider.tags(for: TagType.all()[section]).count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (tableView == entryList) {
            return 1
        } else {
            return TagType.all().count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (tableView == entryList) {
            return nil
        } else {
            return TagType.all()[section].rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == entryList) {
            return UmbyEntryTableViewCell(entry: entries()[indexPath.row])
        } else {
            let tag = tagProvider.tags(for: TagType.all()[indexPath.section])[indexPath.row]
            let isActive = tagFilterList.contains(tag)
            let cell = (tableView.dequeueReusableCell(withIdentifier: UmbyTagTableViewCell.REUSE_IDENTIFIER) ?? UmbyTagTableViewCell.init(tag: tag, isActive: isActive)) as! UmbyTagTableViewCell
            
            cell.configure(tag: tag, isActive: isActive)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == entryList) {
            navigationManager?.navigateToEntryDetail(entries()[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            toggleTagFiltered(for: (tableView.cellForRow(at: indexPath) as! UmbyTagTableViewCell))
        }
    }
    
    func toggleTagFiltered(for cell: UmbyTagTableViewCell) {
        if (tagFilterList.contains(cell.entryTag)) {
            cell.isActive = false
            tagFilterList.remove(at: tagFilterList.index(of: cell.entryTag)!)
            resetSearchFilter()
        } else {
            cell.isActive = true
            tagFilterList.append(cell.entryTag)
            resetSearchFilter()
        }
        
        if (tagFilterList.count == 0) {
            filterButton.title = defaultFilterButtonTitle
        } else if (tagFilterList.count == 1) {
            filterButton.title = tagFilterList[0].text
        } else {
            filterButton.title = "\(tagFilterList.count) tags"
        }
    }
}

extension EntryListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchFilterList = (textField.text ?? "").split(separator: " ").map { String($0) }
        resetSearchFilter()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
