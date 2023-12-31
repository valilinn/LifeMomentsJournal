//
//  EntryListViewModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 21/12/2023.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa

class EntryListViewModel {
    
    var entries = BehaviorSubject(value: [Entry]())
    var quote = BehaviorRelay<String>(value: "")
    let defaultQuote = "The foolish man seeks happiness in the distance, the wise grows it under his feet. \n \n - James Oppenheim"
    private var entriesListener: ListenerRegistration?

    func fetchEntries() {
        guard let userId = AuthenticationService.shared.userId else { return }
        
        // Remove existing listener if any
        entriesListener?.remove()
        
        FirestoreAndStorageService.shared.listenForEntries(for: userId) { [weak self] entries, error in
            if let error = error {
                print("Error fetching entries: \(error)")
                // Handle error appropriately
            } else if let entries = entries {
                let sortedEntries = EntrySorter.shared.sortedEntries(entries: entries)
                self?.entries.onNext(sortedEntries)
            }
        }
    }
    
    deinit {
            entriesListener?.remove()
        }
    
    func deleteEntry(index: Int) {
        guard var currentEntries = try? entries.value() else { return }
        guard index >= 0, index < currentEntries.count else { return }
        
        let entryToDelete = currentEntries[index]
        guard let documentId = entryToDelete.documentId else { return }
        FirestoreAndStorageService.shared.deleteEntry(documentId: documentId) { [weak self] success, error in
            if let error = error {
                print("Error when deleting an entry: \(error)")
            } else {
                currentEntries.remove(at: index)
                self?.entries.onNext(currentEntries)
                print("Entry deleted successfully")
            }
        }
    }
    
    func getQuote() {
        QuoteApiWorker().getQuote { [weak self] quote in
            guard let self = self else { return }
            
            if let quote = quote { 
                let quoteHeader = "\(quote.quoteText) \n \n \(quote.quoteAuthor)"
                self.quote.accept(quoteHeader)
            } else {
                self.quote.accept(self.defaultQuote)
            }
        }
    }
}
