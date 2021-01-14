//
//  JournalController.swift
//  Journal
//
//  Created by Lee McCormick on 1/13/21.
//

import Foundation

class JournalController {
    
    // MARK: - Properties
    static let shared = JournalController()
    var journals: [Journal] = []
    
    // MARK: - CRUD Methods
    func createJournalWith(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistentStorage() 
        
        print("\n\n  createJournalWith(title: String)  ::: journals.count  \(journals.count) ::: journal.title \(newJournal.title) :::  \(newJournal.entries.count)")
    }
    
    func deleteJournal(journal: Journal){
        guard let index = journals.firstIndex(of: journal) else {return}
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistentStorage()
        print("\n\n  addEntryTo :::  journal ::: \(journal)")
        print("\n\n  addEntryTo :::  entry ::: \(entry)")
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        journal.entries.remove(at: index)
    }
    
    // MARK: - Persistance Store
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try JSONDecoder().decode([Journal].self, from: data)
            self.journals = journals
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
        }
    }
}
