//
//  UmbrellaListViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation

class UmbrellaListViewController: EntryListViewController {
    
    override var tableTitle: String {
        get {
            return "Considerations"
        }
    }

    override func entries() -> [Entry] {
        if (filterWithAllSwitch.isOn) {
            return entryProvider?.getEntries(priority: .HIGH,
                                             including: tagFilterList,
                                             with: searchFilterList) ?? []
        } else {
            var allTerms: [String] = Array.init() //searchFilterList.  (contentsOf: tagFilterList.map { $0.text })
            allTerms.append(contentsOf: searchFilterList)
            allTerms.append(contentsOf: tagFilterList.map { $0.text })
            
            return entryProvider?.getEntries(priority: .HIGH,
                                             including: [],
                                             with: allTerms) ?? []
        }
    }
    
}
