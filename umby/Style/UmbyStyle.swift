//
//  UmbyColors.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

struct UmbyStyle {
    struct colors {
        static let blue = UIColor(r: 102, g: 148, b: 247)
        static let darkBlue = UIColor(r: 52, g: 98, b: 197)
        static let white = UIColor(r: 255, g: 255, b: 255)
        static let grey = UIColor(r: 150, g: 150, b: 150)
    }
    
    static let smallCornerRadius: CGFloat = 5
    
    static let font: UIFont = UIFont(name: "Comic Sans MS", size: 24)!
}

typealias UmbyColors = UmbyStyle.colors
