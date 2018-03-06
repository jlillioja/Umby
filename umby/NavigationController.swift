//
//  NavigationController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationManager {
    func navigateToTypeSelector()
    func navigateToFeelingSelector()
    func navigateToTagSelector()
    func navigateToConsiderationSelector()
}

class NavigationController: UINavigationController, NavigationManager {
    
    let navigationManager = self
    
    let textEntryViewController: TextEntryViewController = {
        let vc = TextEntryViewController()
        return vc
    }()
    
    let typeSelectorViewController: TypeSelectorViewController = {
        let vc = TypeSelectorViewController()
        return vc
    }()
    
    let feelingSelectorViewController: FeelingSelectorViewController = {
        let vc = FeelingSelectorViewController()
        return vc
    }()
    
    let tagSelectorViewController: TagSelectorViewController = {
        let vc = TagSelectorViewController()
        return vc
    }()
    
    override func viewDidLoad() {
        title = "UMBY"
        navigationItem.title = title
        
        textEntryViewController.navigationManager = self
        typeSelectorViewController.navigationManager = self
        feelingSelectorViewController.navigationManager = self
        tagSelectorViewController.navigationManager = self
        
        pushViewController(textEntryViewController, animated: true)
    }
    
    func navigateToTypeSelector() {
        pushViewController(typeSelectorViewController, animated: true)
    }
    
    func navigateToFeelingSelector() {
        pushViewController(feelingSelectorViewController, animated: true)
    }
    
    func navigateToTagSelector() {
        pushViewController(tagSelectorViewController, animated: true)
    }
    
    func navigateToConsiderationSelector() {
        
    }
}
