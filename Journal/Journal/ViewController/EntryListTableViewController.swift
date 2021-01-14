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
    
    // MARK: - Lift Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        guard let entry = journal?.entries[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.dateToString()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else {return}
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(entryToDelete: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toShowEntry" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController,
                  let journal = journal else { return }
            destination.journal = journal
            destination.entry = journal.entries[indexPath.row]
            
            print("\n\n  destination.journal on prepare on EntryTVC :::  journal.title ::: \(journal.title)")
            print("\n\n  destination.journal on prepare on EntryTVC :::  journal.title ::: \(journal.entries)")
            
            
        } else if segue.identifier == "toCreateEntry" {
            guard let destination = segue.destination as? EntryDetailViewController,
                  let journal = journal else { return }
            destination.journal = journal
            print("\n\n  destination.journal on prepare on EntryTVC :::  journal.title ::: \(journal.title)")
        }
    }
}

// MARK: - Extensions Date
extension Date {
    func dateToString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
}


