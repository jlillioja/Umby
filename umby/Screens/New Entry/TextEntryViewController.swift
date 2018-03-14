//
//  ViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import UIKit

class TextEntryViewController: UmbyNewEntryViewController {
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("What's going on?")
        view.addSubview(label)
        [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        let textBox = UITextView().forCustom()
        textBox.delegate = self
        textBox.backgroundColor = UmbyColors.white
        textBox.layer.cornerRadius = UmbyStyle.smallCornerRadius
        textBox.font = .systemFont(ofSize: 24.0)
        view.addSubview(textBox)
        [
            textBox.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            textBox.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            textBox.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        let skipButton = UmbyButton(title: "LET'S START WITH FEELINGS") {
            self.navigationManager?.navigateToTypeAndFeelingTagSelector()
            (self.navigationManager as? EntryCreationNavigationController)?.delayTextEntry()
            return ()
        }
        view.addSubview(skipButton)
        [
            skipButton.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: margin),
            skipButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            skipButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToTypeAndFeelingTagSelector()
        }
        view.addSubview(nextButton)
        bottomConstraint = nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        [
            nextButton.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: margin),
            nextButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            nextButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            bottomConstraint!,
        ].activate()
    }
}

extension TextEntryViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        newEntryBuilder?.setText(textView.text)
    }
}

