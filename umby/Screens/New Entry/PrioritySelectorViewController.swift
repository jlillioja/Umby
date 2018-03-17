//
//  ConsiderationSelectorViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class PrioritySelectorViewController: UmbyNewEntryViewController {
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("Is this entry worth further consideration (careful thought)?")
        view.addSubview(label)
        [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        let yesButton = UmbyButton(title: "YES")
        view.addSubview(yesButton)
        [
            yesButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            yesButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            yesButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        let maybeButton = UmbyButton(title: "MAYBE")
        view.addSubview(maybeButton)
        [
            maybeButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: margin),
            maybeButton.leadingAnchor.constraint(equalTo: yesButton.leadingAnchor),
            maybeButton.trailingAnchor.constraint(equalTo: yesButton.trailingAnchor),
        ].activate()
        
        let noButton = UmbyButton(title: "NO")
        view.addSubview(noButton)
        [
            noButton.topAnchor.constraint(equalTo: maybeButton.bottomAnchor, constant: margin),
            noButton.leadingAnchor.constraint(equalTo: maybeButton.leadingAnchor),
            noButton.trailingAnchor.constraint(equalTo: maybeButton.trailingAnchor),
        ].activate()
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToSendEntryViewController()
        }
        view.addSubview(nextButton)
        [
            nextButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            nextButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin),
        ].activate()
        
        yesButton.tap {
            maybeButton.deselect()
            noButton.deselect()
            self.newEntryBuilder?.setPriority(.HIGH)
        }
        
        maybeButton.tap {
            yesButton.deselect()
            noButton.deselect()
            self.newEntryBuilder?.setPriority(.MEDIUM)
        }
        
        noButton.tap {
            yesButton.deselect()
            maybeButton.deselect()
            self.newEntryBuilder?.setPriority(.LOW)
        }
    }
}
