//
//  Entry.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation

struct Entry {
    var text: String?
    var tags: [String]
    var furtherConsideration: Bool
    let date: Date
    
    init(text: String? = nil,
         tags: [String] = [],
         furtherConsideration: Bool = true,
         date: Date = Date()) {
        self.text = text
        self.tags = tags
        self.furtherConsideration = furtherConsideration
        self.date = date
    }
}

extension Entry {
    func tagString() -> String {
        return tags.map { tag in "#\(tag)" }.joined(separator: ", ")
    }
}
