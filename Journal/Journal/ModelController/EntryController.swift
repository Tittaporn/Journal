//
//  EntryController.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import Foundation

class EntryController {
    // Create a shared property
    static var shared = EntryController()
    
    // Add an entries array property, and set its value to an empty array of Entry.
    var entries: [Entry] = []
    

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
    
    
    
    //Mark: - Persistence Data
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    // Saving Data
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // Loading Data
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
}
