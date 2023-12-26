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
    
    var entries = BehaviorSubject(value: [Entry]())

    func fetchEntries() {
        guard let userId = AuthenticationService.shared.userId else { return }
        
        FirestoreAndStorageService.shared.getEntries(for: userId) { [weak self] entries, error in
            if let error = error {
                print("Error fetching entries: \(error)")
                // Handle error appropriately
            } else if let entries = entries {
                self?.entries.onNext(entries)
                // Extract images from all entries and flatten them into a single array
//                let allImages = entries.compactMap { $0.images }.flatMap { $0 }
                print("My entries downloaded")
                print(entries)
//                self?.images.onNext(allImages)
            }
        }
    }
}
