//
//  EntryCreationNavigationController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class EntryCreationNavigationController: UINavigationController, NavigationManager {
    
    var rootNavigationManager: NavigationManager!
    var newEntryBuilder: NewEntryBuilder!
    var tagProvider: TagProvider!
    
    func navigateToTypeAndFeelingTagSelector() {
        navigateForwards()
    }
    
    func navigateToWhoAndWhereTagSelector() {
        navigateForwards()
    }
    
    func navigateToConsiderationSelector() {
        navigateForwards()
    }
    
    func navigateToSendEntryViewController() {
        navigateForwards()
    }
    
    func navigateToEntryList() {
        navigateForwards()
    }
    
    func navigateToEntryDetail(_ entry: Entry) {
        rootNavigationManager.navigateToEntryDetail(entry)
    }
    
    var currentIndex = 0
    func navigateForwards() {
        if currentIndex < entryCreationViewControllers.count {
            pushViewController(entryCreationViewControllers[currentIndex], animated: true)
            currentIndex += 1
        } else {
            rootNavigationManager.navigateToEntryList()
            reset()
        }
    }
    
    func delayTextEntry() {
        if let index = viewControllers.index(of: textEntryViewController) {
            self.viewControllers.remove(at: index)
        }
        entryCreationViewControllers.append(textEntryViewController)
    }
    
    var textEntryViewController: TextEntryViewController!
    var typeAndFeelingTagSelectorViewController: TypeAndFeelingTagSelectorViewController!
    var whoAndWhereTagSelectorViewController: WhoAndWhereTagSelectorViewController!
    var considerationSelectorViewController: ConsiderationSelectorViewController!
    var sendEntryViewController: SendEntryViewController!
    var entryCreationViewControllers: [UmbyNewEntryViewController] = []
    
    override func viewDidLoad() {
        reset()
    }
    
    func reset() {
        textEntryViewController = TextEntryViewController()
        typeAndFeelingTagSelectorViewController = TypeAndFeelingTagSelectorViewController()
        whoAndWhereTagSelectorViewController = WhoAndWhereTagSelectorViewController()
        considerationSelectorViewController = ConsiderationSelectorViewController()
        sendEntryViewController = SendEntryViewController()
        
        entryCreationViewControllers = [
            textEntryViewController,
            typeAndFeelingTagSelectorViewController,
            whoAndWhereTagSelectorViewController,
            considerationSelectorViewController,
            sendEntryViewController,
        ]
        
        entryCreationViewControllers.forEach {
            $0.navigationManager = self
            $0.newEntryBuilder = newEntryBuilder
            $0.tagProvider = tagProvider
        }
        
        currentIndex = 0
        self.setViewControllers([], animated: true)
        navigateForwards()
    }
}
