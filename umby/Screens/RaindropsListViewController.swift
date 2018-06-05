//
//  RaindropsListViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation

class RaindropsListViewController: EntryListViewController {

    override var tableTitle: String {
        get {
            return "Raindrops"
        }
    }

    override func entries() -> [Entry] {
        return entryProvider?.getEntries(priority: Priority.LOW, including: tagFilterList, with: searchFilterList) ?? []
    }
    
}
