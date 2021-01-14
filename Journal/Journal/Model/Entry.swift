//
//  Entry.swift
//  Journal
//
//  Created by Lee McCormick on 1/11/21.
//

import Foundation
class Entry: Codable {
    var title: String
    var body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

// MARK: - Extentions

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        
        //using the timestamp, because there is no way that user can create the entry at the same time.
       // return lhs.timestamp == rhs.timestamp
        
        // This way works, but not logically
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
}


/*
 Equatable Protocol
 Implement the Equatable protocol for the Entry class. The Equatable protocol helps to check for equality between variables of a specific class. To ensure that the two objects we are comparing are the same, we will need to make sure the values of all the variables (title, body, and timestamp) are the same.
 
 1) Conform to the Equatable protocol in an extension to the bottom of the Entry.swift file. This will prompt you with and error - use the fix button to add the necessary protocol stub (function).
 2) Return the result of the comparison between the ‘lhs’ and ‘rhs’ parameters by checking the property values on each parameter.
 3) If you have not already, go back to your EntryController and finish building out the delete function.
 
 */

