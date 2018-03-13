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
    func navigateToTypeAndFeelingTagSelector()
    func navigateToWhoAndWhereTagSelector()
    func navigateToConsiderationSelector()
    func navigateToSendEntryViewController()
    func navigateToEntryList()
    func navigateToEntryDetail(_ entry: Entry)
}

class RootNavigationController: UITabBarController, NavigationManager {
    
    let entryManager = EntryManager()
    
    let textEntryViewController = TextEntryViewController()
    let typeAndFeelingTagSelectorViewController = TypeAndFeelingTagSelectorViewController()
    let tagSelectorViewController = WhoAndWhereTagSelectorViewController()
    let considerationSelectorViewController = ConsiderationSelectorViewController()
    let sendEntryViewController = SendEntryViewController()
    
    let entryListPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let umbrellaEntriesListViewController = UmbrellaListViewController()
    let raindropEntriesListViewController = RaindropsListViewController()
    
    let entryCreationNavigationController = EntryCreationNavigationController()
    let entryListNavigationController = EntryListNavigationController()
    
    override func viewDidLoad() {
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let entryCreationViewControllers = [
            textEntryViewController,
            typeAndFeelingTagSelectorViewController,
            tagSelectorViewController,
            considerationSelectorViewController,
            sendEntryViewController
        ]
        entryCreationViewControllers.forEach {
            $0.navigationManager = self
            $0.newEntryBuilder = entryManager
            $0.tagProvider = entryManager
        }
        
        entryListPageViewController.dataSource = self
        entryListPageViewController.setViewControllers([umbrellaEntriesListViewController],
                                                       direction: .forward,
                                                       animated: true,
                                                       completion: nil)
        entryListPageViewController.view.backgroundColor = UmbyColors.white
        
        umbrellaEntriesListViewController.navigationManager = self
        umbrellaEntriesListViewController.entryProvider = entryManager
        
        raindropEntriesListViewController.navigationManager = self
        raindropEntriesListViewController.entryProvider = entryManager
        
        entryListNavigationController.pushViewController(entryListPageViewController, animated: false)
        entryCreationNavigationController.pushViewController(textEntryViewController, animated: false)
        
        self.viewControllers = [entryListNavigationController]
        selectedViewController = entryListNavigationController
        
        let makeEntryBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(presentEntryCreation))
        entryListPageViewController.navigationItem.rightBarButtonItem = makeEntryBarButtonItem
        
        let doneWithEntryBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(navigateToEntryList))
        entryCreationNavigationController.navigationItem.rightBarButtonItem = doneWithEntryBarButtonItem
    }
    
    @objc func presentEntryCreation() {
        entryManager.beginNewEntry()
        present(entryCreationNavigationController, animated: true, completion: nil)
    }
    
    func navigateToTypeAndFeelingTagSelector() {
        entryCreationNavigationController.pushViewController(typeAndFeelingTagSelectorViewController, animated: true)
    }
    
    func navigateToWhoAndWhereTagSelector() {
        entryCreationNavigationController.pushViewController(tagSelectorViewController, animated: true)
    }
    
    func navigateToConsiderationSelector() {
        entryCreationNavigationController.pushViewController(considerationSelectorViewController, animated: true)
    }
    
    func navigateToSendEntryViewController() {
        entryCreationNavigationController.pushViewController(sendEntryViewController, animated: true)
    }
    
    @objc func navigateToEntryList() {
        entryListNavigationController.popToViewController(entryListPageViewController, animated: true)
        self.selectedViewController = entryListNavigationController
        dismiss(animated: true, completion: nil)
        entryCreationNavigationController.popToViewController(textEntryViewController, animated: false)
    }
    
    func navigateToEntryDetail(_ entry: Entry) {
        entryListNavigationController.pushViewController(EntryDetailViewController(entry), animated: true)
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
