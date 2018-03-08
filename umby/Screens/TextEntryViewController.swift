//
//  ViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import UIKit

class TextEntryViewController: UmbyViewController {
    
    override func loadView() {
        super.loadView()
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UmbyLabel("What's going on?")
        view.addSubview(label)
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ]
        
        let textBox = UITextView().forCustom()
        textBox.backgroundColor = UmbyColors.white
        textBox.layer.cornerRadius = UmbyStyle.smallCornerRadius
        textBox.font = .systemFont(ofSize: 24.0)
        view.addSubview(textBox)
        let textBoxConstraints = [
            textBox.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            textBox.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            textBox.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
        ]
        
        let nextButton = UmbyButton(title: "NEXT") {
            self.navigationManager?.navigateToTypeSelector()
        }
        view.addSubview(nextButton)
        let nextButtonConstraints = [
            nextButton.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: margin),
            nextButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            nextButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        ]
        
        NSLayoutConstraint.activate(labelConstraints+textBoxConstraints+nextButtonConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

