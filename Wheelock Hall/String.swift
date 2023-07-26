//
//  String.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-26.
//

import Foundation

extension String {
    func itemDescription() -> String {
        var description = self
        
        // Add period the end of the description
        if !description.hasPrefix(".") {
            description.append(".")
        }
        
        let prefix = description.prefix(1)
        
        // Capitalize begining of description
        if prefix != prefix.capitalized {
            // remove prefix
            description.remove(at: description.startIndex)
            // insert new capitalized prefix
            description.insert(Character(prefix.capitalized), at: description.startIndex)
        }
        
        return description
    }
}
