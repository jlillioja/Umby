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
        
        let filterButton = UmbyButton(title: "Filter by Tag").small()
        view.addSubview(filterButton)
        [
            filterButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
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
        
        let filterTable = UmbyTable(self)
        filterTable.backgroundColor = UmbyStyle.colors.grey
        view.addSubview(filterTable)
        filterTable.isHidden = true
        [
            filterTable.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            filterTable.leadingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: margin),
            filterTable.trailingAnchor.constraint(equalTo: filterButton.trailingAnchor, constant: -margin),
            filterTable.heightAnchor.constraint(equalToConstant: 300)
        ].activate()
        
        filterButton.onTap {
            filterTable.isHidden = !filterTable.isHidden
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            let cell =  UITableViewCell.init()
            let label = UILabel.init()
            cell.textLabel?.text = tagProvider.tags(for: TagType.all()[indexPath.section])[indexPath.row].text
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == entryList) {
        navigationManager?.navigateToEntryDetail(entries()[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        } else {
            
        }
    }
}
