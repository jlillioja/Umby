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
    func navigateToSendEntryViewController()
    func navigateToEntryList()
}

class RootNavigationController: UITabBarController, NavigationManager {
    
    let makeEntryNavigationController = UINavigationController.init()
    let entryListNavigationController = UINavigationController.init()
    
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
    
    let considerationSelectorViewController = ConsiderationSelectorViewController()
    
    let sendEntryViewController = SendEntryViewController()
    
    let entryListPageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let umbrellaEntriesListViewController = EntryListViewController()
    let raindropEntriesListViewController = EntryListViewController()
    
    override func viewDidLoad() {
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        textEntryViewController.navigationManager = self
        typeSelectorViewController.navigationManager = self
        feelingSelectorViewController.navigationManager = self
        tagSelectorViewController.navigationManager = self
        considerationSelectorViewController.navigationManager = self
        sendEntryViewController.navigationManager = self
        
        entryListPageViewController.dataSource = self
        entryListPageViewController.setViewControllers([umbrellaEntriesListViewController],
                                                       direction: .forward,
                                                       animated: true,
                                                       completion: nil)
        
        entryListNavigationController.pushViewController(entryListPageViewController, animated: false)
        makeEntryNavigationController.pushViewController(textEntryViewController, animated: false)
        
        self.viewControllers = [entryListNavigationController, makeEntryNavigationController]
        selectedViewController = makeEntryNavigationController
    }
    
    func navigateToTypeSelector() {
        makeEntryNavigationController.pushViewController(typeSelectorViewController, animated: true)
    }
    
    func navigateToFeelingSelector() {
        makeEntryNavigationController.pushViewController(feelingSelectorViewController, animated: true)
    }
    
    func navigateToTagSelector() {
        makeEntryNavigationController.pushViewController(tagSelectorViewController, animated: true)
    }
    
    func navigateToConsiderationSelector() {
        makeEntryNavigationController.pushViewController(considerationSelectorViewController, animated: true)
    }
    
    func navigateToSendEntryViewController() {
        makeEntryNavigationController.pushViewController(sendEntryViewController, animated: true)
    }
    
    func navigateToEntryList() {
        entryListNavigationController.popToViewController(entryListPageViewController, animated: true)
        self.selectedViewController = entryListNavigationController
    }
}

extension RootNavigationController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController == raindropEntriesListViewController) {
            return umbrellaEntriesListViewController
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (viewController == umbrellaEntriesListViewController) {
            return raindropEntriesListViewController
        } else {
            return nil
        }
    }
}
