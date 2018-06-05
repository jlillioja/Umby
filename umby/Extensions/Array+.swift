//
//  Array+.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}

extension Array where Element : Hashable {
    func filteringDuplicates() -> [Element] {
        return Array(Set(self))
    }
}

extension Array where Element : Equatable {
    func containsAtLeastOne(of array: [Element]) -> Bool {
        for element in array {
            if (self.contains(element)) {
                return true
            }
        }
        return false
    }
}
