//
//  NewEntryManager.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation

protocol NewEntryBuilder {
    func beginNewEntry()
    func setText(_ text: String)
    func addTags(_ tags: [String])
    func addCustomTag(_ tag: String, forType: TagType)
    func removeTags(_ tags: [String])
    func setFurtherConsideration(_ furtherConsideration: Bool)
    func getEntry() -> Entry?
    func finishEntry()
}

extension NewEntryBuilder {
    func addTag(_ tag: String?) {
        if (tag != nil) {
            addTags([tag!])
        }
    }
    
    func removeTag(_ tag: String?) {
        if (tag != nil) {
            removeTags([tag!])
        }
    }
}

protocol EntryProvider {
    func getEntries(satisfying filter: ((Entry) -> Bool)?) -> [Entry]
}

extension EntryProvider {
    func getUmbrellaEntries() -> [Entry] {
        return getEntries(satisfying: { $0.furtherConsideration })
    }
    
    func getRaindropEntries() -> [Entry] {
        return getEntries(satisfying: { !$0.furtherConsideration })
    }
}

protocol TagProvider {
    func tagsForType() -> [String]
    func tagsForFeelings() -> [String]
    func tagsForWho() -> [String]
    func tagsForWhere() -> [String]
}

class EntryManager: NewEntryBuilder, EntryProvider, TagProvider {
    
    var entries: [Entry] = []
    var currentEntry: Entry?
    
    func beginNewEntry() {
        currentEntry = Entry()
    }
    
    func setText(_ text: String) {
        currentEntry?.text = text
    }
    
    func addTags(_ tags: [String]) {
        currentEntry?.tags.append(contentsOf: tags)
    }
    
    func addCustomTag(_ tag: String, forType key: TagType) {
        tags[key]?.append(tag)
        addTag(tag)
    }
    
    func removeTags(_ tags: [String]) {
        let newTags = currentEntry?.tags.filter { !tags.contains($0)} ?? []
        currentEntry?.tags = newTags
    }
    
    func setFurtherConsideration(_ furtherConsideration: Bool) {
        currentEntry?.furtherConsideration = furtherConsideration
    }
    
    func finishEntry() {
        if (currentEntry != nil) {
            entries.append(currentEntry!)
        }
        currentEntry = nil
        print("Now have entries:\n \(entries)")
    }
    
    func getEntry() -> Entry? {
        return currentEntry
    }
    
    func getEntries(satisfying filter: ((Entry) -> Bool)? = nil) -> [Entry] {
        if (filter != nil) {
            return entries.filter(filter!)
        } else {
            return entries
        }
    }
    
    var tags: [TagType: [String]] = [
        TagType.FEELING : ["Calm", "Angry", "Prepared", "Unprepared", "Happy", "Sad", "Confident", "Afraid", "Proud", "Embarrassed" ],
        TagType.TYPE : ["Idea", "Complaint", "Vision/Dream", "Worry", "Problem", "General Thought", "Note"],
        TagType.WHO : ["Myself", "Parent", "Sibling", "Friend", "Boss", "Coworker", "Stranger", "Significant Other"],
        TagType.WHERE : ["Home", "Work", "Hotel", "Restaurant", "Public Transit", "Gym", "School", "Everywhere"],
        ]
    
    func tagsForType() -> [String] {
        return tags[.TYPE] ?? []
    }
    
    func tagsForFeelings() -> [String] {
        return tags[.FEELING] ?? []
    }
    
    func tagsForWho() -> [String] {
        return tags[.WHO] ?? []
    }
    func tagsForWhere() -> [String] {
        return tags[.WHERE] ?? []
    }
}
