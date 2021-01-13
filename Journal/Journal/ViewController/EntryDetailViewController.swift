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
    var entry: Entry?
    var journal: Journal?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        titleTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveBarButtonItemTapped(_ sender: Any) {
        
        guard let title = titleTextField.text, !title.isEmpty,
              let body =  bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        
        if let entry = entry {
            EntryController.updateEntry(entry: entry, title: title, body: body)
        } else {
            EntryController.createEntryWith(title: title, body: body, journal: journal)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helper Fuctions
    func updateView() {
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    // MARK: - UITextFieldDelegate Protocol
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
}

