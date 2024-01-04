//
//  EntrySorter.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/01/2024.
//

import Foundation

class EntrySorter {
    
    static let shared = EntrySorter()
    
    private init() {}
    
    func sortedEntries(entries: [Entry]) -> [Entry] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let sortedEntries = entries.sorted { entry1, entry2 in
            guard let date1 = dateFormatter.date(from: entry1.date),
                  let date2 = dateFormatter.date(from: entry2.date) else {
                return false // Handle invalid date format
            }
            return date1 > date2
        }
        return sortedEntries
    }
}
