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
    
    var entryProvider: EntryProvider?
    func entries() -> [Entry] {
        return entryProvider?.getEntries(satisfying: { _ in return true }) ?? []
    }
    
    var entryList: UmbyTable! = nil
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UmbyColors.white
        let layoutGuide = view.safeAreaLayoutGuide
        
        entryList = UmbyTable(self)
        view.addSubview(entryList)
        entryList.backgroundColor = UmbyColors.blue
        let constraints = [
            entryList.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            entryList.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            entryList.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            entryList.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin),
        ]
        
        constraints.activate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        entryList.reloadData()
    }
}

extension EntryListViewController: UmbyTableViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UmbyEntryTableViewCell(entry: entries()[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationManager?.navigateToEntryDetail(entries()[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
