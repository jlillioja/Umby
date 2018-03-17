//
//  Entry.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import CoreData

struct Entry {
    var text: String?
    var tags: [Tag]
    var priority: Priority
    let date: Date
    
    init(text: String? = nil,
         tags: [Tag] = [],
         priority: Priority = .LOW,
         date: Date = Date()) {
        self.text = text
        self.tags = tags
        self.priority = priority
        self.date = date
    }
}

extension Entry {
    func tagString() -> String {
        return tags.map { tag in "#\(tag.text)" }.joined(separator: ", ")
    }
    
    func toEntity(with context: NSManagedObjectContext) -> EntryEntity {
        let entity = EntryEntity(context: context)
        entity.text = text
        entity.createdAt = date
        entity.priority = priority.rawValue
        tags.forEach { tag in
            let tagEntity = tag.toEntity(with: context)
            entity.addToTags(tagEntity)
        }
        
        return entity
    }
}

extension EntryEntity {
    func toEntry() -> Entry {
        return Entry(
            text: text,
            tags: self.tags?.flatMap { object in (object as? TagEntity)?.toTag() } ?? [],
            priority: Priority(rawValue: self.priority ?? "") ?? .LOW,
            date: self.createdAt!
        )
    }
}
