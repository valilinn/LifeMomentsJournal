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
    private var imagesListener: ListenerRegistration?
    
    func fetchImages() {
        guard let userId = AuthenticationService.shared.userId else { return }
        
        imagesListener?.remove()
        
        FirestoreAndStorageService.shared.listenForEntries(for: userId) { [weak self] entries, error in
            if let error = error {
                print("Error fetching images: \(error)")
                // Handle error appropriately
            } else if let entries = entries {
                let sortedEntries = EntrySorter.shared.sortedEntries(entries: entries)
                let allImagesSorted = sortedEntries.compactMap { $0.imagesURL }.flatMap { $0 }
                print("Images sorted")
                self?.imagesURL.onNext(allImagesSorted)
            }
        }
    }
    
    deinit {
        imagesListener?.remove()
    }
}
