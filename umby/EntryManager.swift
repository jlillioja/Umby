//
//  NewEntryManager.swift
//  umby
//
//  Created by Jacob Lillioja on 3/8/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol NewEntryBuilder {
    func beginNewEntry()
    func setText(_ text: String)
    func addTag(_ tag: Tag)
    func addCustomTag(_ tag: Tag)
    func removeTag(_ tag: Tag)
    func removeCustomTag(_ tag: Tag)
    func setPriority(_ priority: Priority)
    func getEntry() -> Entry?
    func finishEntry()
}

extension NewEntryBuilder {
    func addTag(_ text: String, type: TagType) {
        addTag(Tag(text: text, type: type))
    }
    
    func addCustomTag(_ tag: String, forType key: TagType) {
        addCustomTag(Tag(text: tag, type: key))
    }
}

protocol EntryProvider {
    func getEntries(satisfying filter: ((Entry) -> Bool)?) -> [Entry]
}

extension EntryProvider {
    func getUmbrellaEntries() -> [Entry] {
        return getEntries(satisfying: { $0.priority == .HIGH })
    }
    
    func getRaindropEntries() -> [Entry] {
        return getEntries(satisfying: { $0.priority != .HIGH })
    }
    
    private func getEntries(priority: Priority, including tags: [Tag]) -> [Entry] {
        return getEntries(satisfying: { entry in
            guard entry.priority == priority else { return false }
            for tag in tags {
                if (!entry.tags.contains(tag)) {
                    return false
                }
            }
            return true
        })
    }
    
    func getEntries(priority: Priority, including tags: [Tag], with searchTerms: [String]) -> [Entry] {
        return getEntries(priority: priority, including: tags).filter { entry in
            guard searchTerms.count > 0 else { return true }
            for term in searchTerms {
                if ((entry.text?.contains(term) ?? false)
                    || entry.tags.map {$0.text}.containsAtLeastOne(of: searchTerms)) {
                    return true
                }
            }
            return false
        }
    }
}

protocol TagProvider {
    func tags(for tag: TagType) -> [Tag]
}

class EntryManager: NewEntryBuilder, EntryProvider, TagProvider {
    
    var entries: [Entry] = []
    private var entryEntities: [EntryEntity] = []
    var currentEntry: Entry?
    
    static let defaultTags: [Tag] =
        ["Calm", "Angry", "Prepared", "Unprepared", "Happy", "Sad", "Confident", "Afraid", "Proud", "Embarrassed" ]
            .map { tagString in Tag(text: tagString, type: .FEELING) } +
            ["Idea", "Complaint", "Vision", "Dream", "Worry", "Problem", "General Thought", "Note"]
                .map { tagString in Tag(text: tagString, type: .TYPE) } +
            ["Myself", "Parent", "Sibling", "Friend", "Boss", "Coworker", "Child", "Significant Other"]
                .map { tagString in Tag(text: tagString, type: .WHO) } +
            ["Home", "Work", "Hotel", "Restaurant", "Public Transit", "Gym", "School", "Everywhere"]
                .map { tagString in Tag(text: tagString, type: .WHERE) }
    
    var customTags: [Tag] = []
    
    let coreDataContext: NSManagedObjectContext?
    
    init() {
        coreDataContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        refreshEntries()
        refreshTags()
    }
    
    func beginNewEntry() {
        currentEntry = Entry()
    }
    
    func setText(_ text: String) {
        currentEntry?.text = text
    }
    
    func addTag(_ tag: Tag) {
        currentEntry?.tags.append(tag)
    }
    
    func addCustomTag(_ tag: Tag) {
        customTags.append(tag)
        addTag(tag)
    }
    
    func removeTag(_ tag: Tag) {
        let newTags = currentEntry?.tags.filter { $0 != tag } ?? []
        currentEntry?.tags = newTags
    }
    
    func removeCustomTag(_ tag: Tag) {
        removeTag(tag)
    }
    
    func setPriority(_ priority: Priority) {
        currentEntry?.priority = priority
    }
    
    func finishEntry() {
        if let context = coreDataContext, currentEntry != nil {
            entries.append(currentEntry!)
            do {
                entryEntities.append(currentEntry!.toEntity(with: context))
                try context.save()
            } catch let error as NSError {
                print("Cannot save right now:\n\(error)")
            }
        } else {
            print("Cannot save right now")
        }
        currentEntry = nil
        refreshEntries()
        print("Now have entries:\n\(entries)")
    }
    
    private func refreshEntries() {
        do {
            entryEntities = (try (coreDataContext?.fetch(NSFetchRequest<EntryEntity>(entityName: "Entry"))))!
            entries = entryEntities.compactMap { $0.toEntry() }
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func refreshTags() {
        do {
            let tagEntities = try (coreDataContext?.fetch(NSFetchRequest<TagEntity>(entityName: "Tag"))) as! [TagEntity]
            customTags = tagEntities.compactMap { $0.toTag() }.filteringDuplicates()
        } catch let error as NSError {
            print(error)
        }
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
    
    func tags(for tag: TagType) -> [Tag] {
        return (EntryManager.defaultTags + customTags).filter { $0.type == tag }.filteringDuplicates()
    }
}
