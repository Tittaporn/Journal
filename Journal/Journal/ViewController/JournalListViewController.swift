//
//  JournalListViewController.swift
//  Journal
//
//  Created by Lee McCormick on 1/13/21.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        JournalController.shared.loadFromPersistentStorage()
        //journalListTableView.reloadData()
        //print("Hello JournalListViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
        print("Hello JournalListViewController")
    }
    
    // MARK: - Actions
    
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        print("createNewJournalButtonTapped")
        guard let title = journalTitleTextField.text, !title.isEmpty else {return}
        JournalController.shared.createJournalWith(title: title)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        let journal = JournalController.shared.journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count) entries"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let journalToDelete = JournalController.shared.journals[indexPath.row]
        JournalController.shared.deleteJournal(journal: journalToDelete)
        tableView.deleteRows(at: [indexPath], with: .middle)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryListTableViewController" {
            guard let indexPath = journalListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryListTableViewController else {return}
            let journal = JournalController.shared.journals[indexPath.row]
            destination.journal = journal
            print("\n\n  destination.journal on prepare on JournalLisTVC :::  journal.title ::: \(journal.title) :::: journal.entries.count \(journal.entries.count)")
        }
    }
}


