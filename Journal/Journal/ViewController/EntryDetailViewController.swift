//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    //Mark: - Properties
    var entry: Entry?
    
    
    //Mark: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        titleTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //Mark: - Actions
    
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        
        titleTextField.text = ""
        bodyTextView.text = ""
        
        
    }
    
    @IBAction func saveBarButtonItemTapped(_ sender: Any) {
      /*
        
        //check if the optional entry property holds an entry.
        if entry != nil {
            // If it does, add a print statement that says “to be implemented tomorrow”.
            print("to be implemented tomorrow")

        } else {

           // If not (meaning if the entry property is nil, call the createEntryWith()
            guard let title = titleTextField.text,
                  let body =  bodyTextView.text else {return}
            
            EntryController.shared.createEntryWith(title: title, body: body)
       }
        */
        
        
        guard let title = titleTextField.text, !title.isEmpty,
              
              let body =  bodyTextView.text, !body.isEmpty else {return}
        EntryController.shared.createEntryWith(title: title, body: body)
        
        
        //add code to dismiss the current view and pop back to the EntryListTableViewController.
      
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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

/*
 Wrap-Up Detail View
 Hop back to your EntryDetailViewController and finish out the remaining steps.
 
 1) Add a UIBarButtonItem to the UINavigationBar as a Save System Item and add an IBAction to the class file called saveButtonTapped.
 2) In the saveButtonTapped IBAction, using an if let (conditional unwrapping) check if the optional entry property holds an entry. If it does, add a print statement that says “to be implemented tomorrow”. If not (meaning if the entry property is nil, call the createEntryWith() function on the EntryController. This will require you to use your outlets to access the users title and body inputs.
 3) Still inside the saveButtonTapped IBAction, but outside of the if let, add code to dismiss the current view and pop back to the EntryListTableViewController.
 4) Add an updateViews() function that checks if the optional entry property holds an entry (hint: use a guard statement to do this). If it does, implement the function to update all view elements that reflect details about the model object entry (in this case, the titleTextField and bodyTextView)
 5) Update the viewDidLoad() function to call updateViews()
 
 */
