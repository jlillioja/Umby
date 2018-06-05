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
    
    var title: String?
    {
        get {
            return self.title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    init(title: String, _ onTap: @escaping (() -> Void?)) {
        super.init(frame: .zero)
        
        forCustom()
        
        setTitle(title, for: .normal)
        setTitleColor(UmbyColors.darkBlue, for: .normal)
        self.titleLabel?.font = UmbyStyle.font
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        backgroundColor = UmbyColors.white
//        setBackgroundImage(UmbyColors.white.image(), for: .normal)
//        setBackgroundImage(UmbyColors.grey.image(), for: .selected)
        layer.cornerRadius = UmbyStyle.smallCornerRadius
        self.tap {
            onTap()
        }
    }
    
    func small() -> Self {
        self.titleLabel?.font = UmbyStyle.font.withSize(12)
        return self
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
