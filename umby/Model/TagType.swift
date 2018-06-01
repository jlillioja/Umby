//
//  TagType.swift
//  umby
//
//  Created by Jacob Lillioja on 3/13/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation

enum TagType: String {
    case TYPE = "Type"
    case FEELING = "Feeling"
    case WHO = "Who"
    case WHERE = "Where"
    case UNKNOWN = ""
}

extension TagType {
    static func all() -> [TagType] {
        return [TagType.TYPE, TagType.FEELING, TagType.WHO, TagType.WHERE]
    }
}
