//
//  EntryListNavigationController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class EntryListNavigationController: UINavigationController {
    
    static let TAG = 2
    
    override func viewDidLoad() {
        tabBarItem = UITabBarItem.init(tabBarSystemItem: .history, tag: EntryListNavigationController.TAG)
    }
}
