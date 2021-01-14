//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
   // MARK: - Properties
    var journal: Journal?
    var entry: Entry?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        updateView()
        print("\n\n  viewDidLoad() ::: journal  ::: \(journal?.title)")
        print("\n\n  viewDidLoad() ::: entry  ::: \(entry?.title)")
    }
    
  // MARK: - Actions
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveBarButtonItemTapped(_ sender: Any) {
        print("saveBarButtonItemTapped")
        guard let title = titleTextField.text, !title.isEmpty,
              let body =  bodyTextView.text, !body.isEmpty,
              let journal = journal else {return}

        if let entry = entry {
            EntryController.update(entry: entry, title: title, body: body)
            print("\n\n  update on SaveBarButtonItems  ::: journal.entries.count  \(journal.entries.count) ::: journal.title \(journal.title)")
        } else {
            EntryController.createEntryWith(title: title, body: body, journal: journal)
            print("\n\n  createEntryWith on SaveBarButtonItems  ::: journal.entries.count  \(journal.entries.count) ::: journal.title \(journal.title)")
        }
      
        
       navigationController?.popViewController(animated: true)
    }
    
    
    //Mark: - Helper Fuctions
    
    func updateView() {
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
}

