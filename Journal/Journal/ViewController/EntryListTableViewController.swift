//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        EntryController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = entry.title
        
        return cell
    }
    


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            EntryController.shared.deleteEntry(entryToDelete: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // IIDOO
        //Identifier
        if segue.identifier == "toEntryDetailVC" {
            
            // Index
            guard let index = tableView.indexPathForSelectedRow else {return}
           
            // Destination
            guard let destination = segue.destination as? EntryDetailViewController else { return }
            
            // Object to Send
            let entry = EntryController.shared.entries[index.row]
            
            // Object to Receive
            destination.entry = entry
           
        }
    }
}
