//
//  UmbyButton.swift
//  umby
//
//  Created by Jacob Lillioja on 3/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class UmbyButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, _ onTap: @escaping (() -> Void?)) {
        super.init(frame: .zero)
        
        forCustom()
        
        setTitle(title, for: .normal)
        setTitleColor(UmbyColors.darkBlue, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        backgroundColor = UmbyColors.white
        layer.cornerRadius = UmbyStyle.smallCornerRadius
        self.onTap {
            self.backgroundColor = UmbyColors.grey
            onTap()
        }
    }

}
