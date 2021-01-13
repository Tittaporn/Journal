//
//  JournalController.swift
//  Journal
//
//  Created by Lee McCormick on 1/12/21.
//

import Foundation

class JournalController {
    
    // MARK: - Properties
    static var shared = JournalController()
    
    // Source of Truth S.O.T
    var journals: [Journal] = []
    
    // MARK: - CRUD Methods
    func createJournalWith(title: String) {
        let journal = Journal(title: title)
        print(journal.title)
        journals.append(journal)
        saveToPersistenceStore()
    }
    
    func deleteJournal(journalToDelete: Journal) {
        guard let index = journals.firstIndex(of: journalToDelete) else {return}
        journals.remove(at: index)
        saveToPersistenceStore()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistenceStore()
        print("addEntryTo  journal.entries.append(entry):::: \( journal.entries.count)")
        print("addEntryTo  journal :::: \( journal.title)")
        
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        journal.entries.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Save and Load From Persistance Store
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch { //automatic catch error
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistanceStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
