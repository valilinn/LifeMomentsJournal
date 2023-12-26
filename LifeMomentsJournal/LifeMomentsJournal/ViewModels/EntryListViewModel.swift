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

    
//    func downloadEntries(userId: String) {
//        var entriesValues = [Entry]()
//        print("func downloadEntries works")
//        FirestoreAndStorageService.shared.getEntries(for: userId) { entries, error  in
//            guard let entriesValues = entries else { return }
//            self.entries = entriesValues
//            print(entries)
//            
//        }
//        return self.entries.onNext(entriesValue)
        
    let date = String()
    let title = BehaviorSubject<String>(value: "")
    let content = BehaviorSubject<String>(value: "")
    let images = BehaviorSubject<[Data]>(value: [])
    
    
    //only images now, fix it
    func fetchEntries() {
        guard let userId = AuthenticationService.shared.userId else {
            return
        }
        
        FirestoreAndStorageService.shared.getEntries(for: userId) { [weak self] (entries, error) in
            if let error = error {
                print("Error fetching entries: \(error)")
                // Handle error appropriately
            } else if let entries = entries {
                // Extract images from all entries and flatten them into a single array
                let allImages = entries.compactMap { $0.images }.flatMap { $0 }
                self?.images.onNext(allImages)
            }
        }
    }
}
