//
//  UmbyTextField.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, delegate: UITextFieldDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        
        forCustom()
        
        borderStyle = .roundedRect
        attributedPlaceholder = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.foregroundColor: UmbyColors.grey
            ])
        (value(forKey: "_placeholderLabel") as? UILabel)?.adjustsFontSizeToFitWidth = true
        backgroundColor = UmbyColors.white
        layer.cornerRadius = UmbyStyle.smallCornerRadius
    }
}
