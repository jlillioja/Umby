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
    
    func currentIndex() -> Int? {
        return entryCreationViewControllers.index(of: topViewController as! UmbyNewEntryViewController)
    }
    
    func navigateForwards() {
        if let currentIndex = currentIndex(),
            currentIndex+1 < entryCreationViewControllers.count {
            pushViewController(entryCreationViewControllers[currentIndex+1], animated: true)
        } else {
            rootNavigationManager.navigateToEntryList()
            reset()
        }
    }
    
    func delayTextEntry() {
        if let index = viewControllers.index(of: textEntryViewController) {
            self.viewControllers.remove(at: index)
        }
        if let index = entryCreationViewControllers.index(of: textEntryViewController) {
            entryCreationViewControllers.remove(at: index)
        }
        entryCreationViewControllers.append(textEntryViewController)
    }
    
    var textEntryViewController: TextEntryViewController!
    var typeAndFeelingTagSelectorViewController: TypeAndFeelingTagSelectorViewController!
    var whoAndWhereTagSelectorViewController: WhoAndWhereTagSelectorViewController!
    var considerationSelectorViewController: PrioritySelectorViewController!
    var sendEntryViewController: SendEntryViewController!
    var entryCreationViewControllers: [UmbyNewEntryViewController] = []
    
    override func viewDidLoad() {
        reset()
    }
    
    func reset() {
        textEntryViewController = TextEntryViewController()
        typeAndFeelingTagSelectorViewController = TypeAndFeelingTagSelectorViewController()
        whoAndWhereTagSelectorViewController = WhoAndWhereTagSelectorViewController()
        considerationSelectorViewController = PrioritySelectorViewController()
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
        
        self.setViewControllers([textEntryViewController], animated: true)
    }
}
