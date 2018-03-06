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
        static let white = UIColor(r: 255, g: 255, b: 255)
        static let grey = UIColor(r: 200, g: 200, b: 200)
    }
    
    static let smallCornerRadius: CGFloat = 5
}

typealias UmbyColors = UmbyStyle.colors
