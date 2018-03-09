//
//  UmbyViewController.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyViewController: UIViewController {
    
    var navigationManager: NavigationManager?
    var constraints: [NSLayoutConstraint] = []
    
    let margin: CGFloat = 25.0
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UmbyColors.blue
    }
    
}
