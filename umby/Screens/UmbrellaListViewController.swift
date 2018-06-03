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
        return entryProvider?.getEntries(priority: .HIGH, including: tagFilterList) ?? []
    }
    
}
