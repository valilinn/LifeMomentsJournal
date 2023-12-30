//
//  ImagesViewModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/12/2023.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa

class ImagesViewModel {
    
    let imagesURL = BehaviorSubject<[String]>(value: [])
    private var entriesListener: ListenerRegistration?
    
    func fetchImages () {
        guard let userId = AuthenticationService.shared.userId else { return }
        
        entriesListener?.remove()
        
        FirestoreAndStorageService.shared.listenForEntries(for: userId) { [weak self] entries, error in
            if let error = error {
                print("Error fetching images: \(error)")
                // Handle error appropriately
            } else if let entries = entries {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let sortedEntries = entries.sorted { entry1, entry2 in
                    guard let date1 = dateFormatter.date(from: entry1.date),
                          let date2 = dateFormatter.date(from: entry2.date) else {
                        return false // Handle invalid date format
                    }
                    return date1 > date2
                }
                let allImagesSorted = sortedEntries.compactMap { $0.imagesURL }.flatMap { $0 }
                print("sorted images \(allImagesSorted)")
                self?.imagesURL.onNext(allImagesSorted)
            }
        }
        
    }
    
    deinit {
            // Remove the listener when the ViewModel is deallocated
            entriesListener?.remove()
        }
}
