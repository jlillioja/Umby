//
//  ViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import UIKit

class TextEntryViewController: UIViewController {
    
    var navigationManager: NavigationManager?

    override func loadView() {
        view = UIView()
        view.backgroundColor = UmbyColors.blue
        let layoutGuide = view.safeAreaLayoutGuide
        
        let label = UILabel().forCustom()
        label.text = "What's going on?"
        label.textAlignment = .center
        label.textColor = UmbyColors.white
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.addSubview(label)
        
        let textBox = UITextView().forCustom()
        textBox.backgroundColor = UmbyColors.white
        textBox.layer.cornerRadius = UmbyStyle.smallCornerRadius
        textBox.font = .systemFont(ofSize: 24.0)
        view.addSubview(textBox)
        
        let nextButton = UIButton().forCustom()
        nextButton.backgroundColor = UmbyColors.white
        nextButton.layer.cornerRadius = UmbyStyle.smallCornerRadius
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.onTap { [weak self] in
            self?.navigationManager?.navigateToTypeSelector()
        }
        view.addSubview(nextButton)
        
        let margin: CGFloat = 30.0
        [
            label.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            textBox.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            textBox.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            textBox.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            textBox.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -margin),
            nextButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            nextButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin),
            nextButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin)
        ].activate()
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

