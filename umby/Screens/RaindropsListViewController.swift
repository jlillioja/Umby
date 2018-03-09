//
//  RaindropsListViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation

class RaindropsListViewController: EntryListViewController {
    
    override func entries() -> [Entry] {
        return entryProvider?.getRaindropEntries() ?? []
    }
    
}
