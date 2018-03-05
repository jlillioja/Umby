//
//  NavigationController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        let viewController = ViewController()
        viewController.navigationManager = self
        pushViewController(viewController, animated: true)
    }
    
    func navigateToTypeSelector() {
        pushViewController(TypeSelectorViewController(), animated: true)
    }
    
}
