//
//  UmbyRadioButtonGroup.swift
//  umby
//
//  Created by Jacob Lillioja on 3/13/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyRadioButtonGroup: UIView {
    
    init(buttons: [UmbyButton]) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
