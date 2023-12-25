//
//  EntryListViewModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 21/12/2023.
//

import Foundation
import RxSwift
import RxCocoa

class EntryListViewModel {
//    var entries = BehaviorSubject(value: [Entry]())
    var entries = [Entry]()
    
    func downloadEntries(userId: String) {
        var entriesValues = [Entry]()
        print("func downloadEntries works")
        FirestoreAndStorageService.shared.getEntries(for: userId) { entries, error  in
            guard let entriesValues = entries else { return }
            self.entries = entriesValues
            print(entries)
            
        }
//        return self.entries.onNext(entriesValue)
        
    }
}
