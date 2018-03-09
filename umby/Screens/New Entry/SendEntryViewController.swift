//
//  SendEntryViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class SendEntryViewController: UmbyNewEntryViewController {
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("Do you want to send this entry to anyone?")
        view.addSubview(label)
        constraints += [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin)
        ]
        
        let sendFullEntryButton = UmbyButton(title: "SEND FULL ENTRY") {
            _ = 1
        }
        view.addSubview(sendFullEntryButton)
        constraints += [
            sendFullEntryButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            sendFullEntryButton.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            sendFullEntryButton.trailingAnchor.constraint(equalTo: label.trailingAnchor),
        ]
        
        let sendTagsOnlyButton = UmbyButton(title: "SEND TAGS ONLY") {
            _ = 1
        }
        view.addSubview(sendTagsOnlyButton)
        constraints += [
            sendTagsOnlyButton.topAnchor.constraint(equalTo: sendFullEntryButton.bottomAnchor, constant: margin),
            sendTagsOnlyButton.leadingAnchor.constraint(equalTo: sendFullEntryButton.leadingAnchor),
            sendTagsOnlyButton.trailingAnchor.constraint(equalTo: sendFullEntryButton.trailingAnchor),
        ]
        
        let noButton = UmbyButton(title: "DO NOT SEND") {
            _ = 1
        }
        view.addSubview(noButton)
        constraints += [
            noButton.topAnchor.constraint(equalTo: sendTagsOnlyButton.bottomAnchor, constant: margin),
            noButton.leadingAnchor.constraint(equalTo: sendTagsOnlyButton.leadingAnchor),
            noButton.trailingAnchor.constraint(equalTo: sendTagsOnlyButton.trailingAnchor),
        ]
        
        let doneButton = UmbyButton(title: "DONE") {
            self.navigationManager?.navigateToEntryList()
            self.newEntryBuilder?.finishEntry()
            return ()
        }
        view.addSubview(doneButton)
        constraints += [
            doneButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin),
            doneButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            doneButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            doneButton.topAnchor.constraint(greaterThanOrEqualTo: noButton.bottomAnchor, constant: margin),
        ]
        
        constraints.activate()
    }
}
