//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    
    // MARK: - Lift Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
        
        //format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        cell.detailTextLabel?.text = formatter.string(from: entry.timestamp)
        
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
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


