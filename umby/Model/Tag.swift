//
//  Tag.swift
//  umby
//
//  Created by Jacob Lillioja on 3/16/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Tag {
    let text: String
    let type: TagType
}

extension Tag {
    func toEntity(with context: NSManagedObjectContext) -> TagEntity {
        let entity = TagEntity(context: context)
        entity.text = text
        entity.type = type.rawValue
        return entity
    }
}

extension Tag: Equatable {
    static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return lhs.text == rhs.text
        && lhs.type == rhs.type
    }
}

extension TagEntity {
    func toTag() -> Tag {
        return Tag(text: text ?? "", type: TagType(rawValue: self.type ?? "") ?? .UNKNOWN)
    }
}
