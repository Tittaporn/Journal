//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var journal: Journal?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.shared.loadFromPersistanceStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JournalController.shared.loadFromPersistanceStorage()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        guard let entry = journal?.entries[indexPath.row] else { return cell }
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.dateToString()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let journal = journal else {return}
        if editingStyle == .delete {
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(entryToDelete: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // IIDOO
        guard let destination = segue.destination as? EntryDetailViewController,
              let journal = journal
        else { return }
        //Identifier
        if segue.identifier == "showEntry" {
            
            guard let index = tableView.indexPathForSelectedRow else {return}
            // Object to Send
            let entry = journal.entries[index.row]
            destination.journal = journal
            // Object to Receive
            destination.entry = entry
            
        } else if segue.identifier == "createNewEntry" {
            destination.journal = journal
            
        }
    }
}

// MARK: - Date Extension
extension Date {
    
    //    Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
    //    09/12/2018                        --> MM/dd/yyyy
    //    09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
    //    Sep 12, 2:11 PM                   --> MMM d, h:mm a
    //    September 2018                    --> MMMM yyyy
    //    Sep 12, 2018                      --> MMM d, yyyy
    //    Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
    //    2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
    //    12.09.18                          --> dd.MM.yy
    //    10:41:02.112                      --> HH:mm:ss.SSS
    
    func dateToString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
}


