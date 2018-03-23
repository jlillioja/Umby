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
        font = .systemFont(ofSize: 24.0)
        setContentHuggingPriority(.defaultHigh, for: .vertical)
        textAlignment = .center
        numberOfLines = 0
    }
    
    func small() -> Self {
        font = .systemFont(ofSize: 12.0)
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
