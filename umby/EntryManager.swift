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
    func removeTags(_ tags: [String])
    func setFurtherConsideration(_ furtherConsideration: Bool)
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
    
    func removeTags(_ tags: [String]) {
        currentEntry?.tags = currentEntry?.tags.filter { !tags.contains($0)} ?? []
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
    
    func getEntries(satisfying filter: ((Entry) -> Bool)? = nil) -> [Entry] {
        if (filter != nil) {
            return entries.filter(filter!)
        } else {
            return entries
        }
    }
    
    func tagsForType() -> [String] {
        return ["Idea", "Complaint", "Vision/Dream", "Worry", "Problem", "General Thought"]
    }
    
    func tagsForFeelings() -> [String] {
        return ["Calm", "Angry", "Prepared", "Unprepared", "Happy", "Sad", "Confident", "Afraid", "Proud", "Embarrassed" ]
    }
    
    func tagsForWho() -> [String] {
        return ["Myself", "Parent", "Sibling", "Friend", "Boss", "Coworker", "Stranger", "Significant Other"]
    }
    func tagsForWhere() -> [String] {
        return ["Home", "Work", "Hotel", "Restaurant", "Public Transit", "Gym", "School", "Everywhere"]
    }
}
