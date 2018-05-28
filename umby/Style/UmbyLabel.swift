//
//  UmbyLabel.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        forCustom()
        
        textColor = UmbyColors.white
        adjustsFontSizeToFitWidth = true
        setContentHuggingPriority(.defaultHigh, for: .vertical)
        textAlignment = .center
        numberOfLines = 0
        font = UmbyStyle.font
    }
    
    func small() -> Self {
        font = font.withSize(12)
        return self
    }
    
    func leftAligned() -> Self {
        textAlignment = .left
        return self
    }
    
    func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    convenience init(_ text: String) {
        self.init()
        self.text = text
    }
}
