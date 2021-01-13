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
        print("Created New Entry")
    }
    
    static func updateEntry(entry: Entry, title: String, body: String) {
        
        entry.title = title
        entry.body = body
        
        
        JournalController.shared.saveToPersistenceStore()
    }
    
    static func deleteEntry(entryToDelete: Entry, journal: Journal) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entryToDelete)
    }
    


}

/*
    // Create a createEntryWith(title: ...) function that takes in a title, and body. It should create a new instance of Entry and add it to the entries array
    func createEntryWith(title: String, body: String) {
        let entry = Entry(title: title, body: body)
        entries.append(entry)
        
        // Save
        saveToPersistenceStore()
    }
    
    
    // Create a delete(entry: Entry) function that removes the entry from the entries array
    func deleteEntry(entryToDelete: Entry) {
        guard let index = entries.firstIndex(of: entryToDelete) else { return }
       
        entries.remove(at: index)
        saveToPersistenceStore()
    }
    

}
 */
