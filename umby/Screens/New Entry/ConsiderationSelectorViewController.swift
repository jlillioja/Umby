//
//  ConsiderationSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class ConsiderationSelectorViewController: UmbyNewEntryViewController {
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("Is this entry worth further consideration (careful thought)?")
        view.addSubview(label)
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ]
        
        let yesButton = UmbyButton(title: "YES") {
            self.newEntryBuilder?.setFurtherConsideration(true)
        }
        view.addSubview(yesButton)
        let yesButtonConstraints = [
            yesButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            yesButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            yesButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ]
        
        let maybeButton = UmbyButton(title: "MAYBE") {
            self.newEntryBuilder?.setFurtherConsideration(false)
        }
        view.addSubview(maybeButton)
        let maybeButtonConstraints = [
            maybeButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: margin),
            maybeButton.leadingAnchor.constraint(equalTo: yesButton.leadingAnchor),
            maybeButton.trailingAnchor.constraint(equalTo: yesButton.trailingAnchor),
        ]
        
        let noButton = UmbyButton(title: "NO") {
            self.newEntryBuilder?.setFurtherConsideration(false)
        }
        view.addSubview(noButton)
        let noButtonConstraints = [
            noButton.topAnchor.constraint(equalTo: maybeButton.bottomAnchor, constant: margin),
            noButton.leadingAnchor.constraint(equalTo: maybeButton.leadingAnchor),
            noButton.trailingAnchor.constraint(equalTo: maybeButton.trailingAnchor),
        ]
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToSendEntryViewController()
        }
        view.addSubview(nextButton)
        let nextButtonConstraints = [
            nextButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            nextButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin),
        ]
        NSLayoutConstraint.activate(labelConstraints+yesButtonConstraints+maybeButtonConstraints+noButtonConstraints+nextButtonConstraints)
        
    }
}
