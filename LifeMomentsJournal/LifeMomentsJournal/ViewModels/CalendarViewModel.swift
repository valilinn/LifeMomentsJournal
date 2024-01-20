//
//  CalendarViewModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 20/01/2024.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa

class CalendarViewModel {
    
    private var entries = BehaviorSubject(value: [Entry]())
    private var dates = BehaviorSubject(value: [DateComponents]())
    private var entriesListener: ListenerRegistration?
    
    func setSelectedDates() {
        guard let userId = AuthenticationService.shared.userId else { return }
        entriesListener?.remove()
        
        var datesArray = [DateComponents]()
        
        FirestoreAndStorageService.shared.listenForEntries(for: userId) { [weak self] entries, error in
            if let error = error {
                print("Error fetching entries: \(error)")
            } else if let entries = entries {
                print(entries.first?.date)
                print("1")
            }
        }
        
    }
    
    deinit {
        entriesListener?.remove()
    }
}
