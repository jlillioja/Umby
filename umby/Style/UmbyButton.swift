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
    
    convenience init(title: String) {
        self.init(title: title) { return () }
    }
    
    init(title: String, _ onTap: @escaping (() -> Void?)) {
        super.init(frame: .zero)
        
        forCustom()
        
        setTitle(title, for: .normal)
        setTitleColor(UmbyColors.darkBlue, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        backgroundColor = UmbyColors.white
//        setBackgroundImage(UmbyColors.white.image(), for: .normal)
//        setBackgroundImage(UmbyColors.grey.image(), for: .selected)
        layer.cornerRadius = UmbyStyle.smallCornerRadius
        self.tap {
            onTap()
        }
    }
    
    func select() {
        backgroundColor = UmbyColors.grey
    }
    
    func deselect() {
        backgroundColor = UmbyColors.white
    }
    
    func tap(action: (() -> Void)?) {
        self.onTap {
            self.select()
            action?()
        }
    }
}
