//
//  EntryController.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import Foundation

class EntryController {
    
    // MARK: - CRUD Methods
    static func createEntryWith(title: String, body: String, journal: Journal) {
        let entry = Entry(title: title, body: body)
        JournalController.shared.addEntryTo(journal: journal, entry: entry)
        print("\n\n createEntryWith ::: title ::: \(title)")
        print("\n\n createEntryWith  ::: body ::: \(body)")
    }
    
    static func update(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistentStorage()
        print("\n\n update ::: title ::: \(title)")
        print("\n\n update  ::: body ::: \(body)")
    }
    
    static func deleteEntry(entryToDelete: Entry, journal: Journal) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entryToDelete)
    }
    
    
}
