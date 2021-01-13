//
//  JournalListViewController.swift
//  Journal
//
//  Created by Lee McCormick on 1/12/21.
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
        JournalController.shared.loadFromPersistanceStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: UIButton) {
        
        guard let journalTitle = journalTitleTextField.text, !journalTitle.isEmpty else {return}
        
        JournalController.shared.createJournalWith(title: journalTitle)
        print(JournalController.shared.journals.count)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(JournalController.shared.journals.count)")
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalListTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        let journal = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count) entries."
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        if segue.identifier == "toEntryList" {
            guard let indexPath = journalListTableView.indexPathForSelectedRow else {return}
            guard let destination = segue.destination as? EntryListTableViewController else {return}
            let journal = JournalController.shared.journals[indexPath.row]
            destination.journal = journal
        }
    }
}
