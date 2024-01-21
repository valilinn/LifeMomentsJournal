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
    var dates = BehaviorSubject(value: [DateComponents]())
    private var entriesListener: ListenerRegistration?
    

    
    func getDates() {
        guard let userId = AuthenticationService.shared.userId else { return }
        entriesListener?.remove()
        
        var datesArray = [DateComponents]()
        
        FirestoreAndStorageService.shared.listenForEntries(for: userId) { [weak self] entries, error in
            if let error = error {
                print("Error fetching entries: \(error)")
            } else if let entries = entries {
                for (index, entry) in entries.enumerated() {
//                    print(entry.date)
                    let dateString = entry.date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    if let date = dateFormatter.date(from: dateString) {
                        let calendar = Calendar(identifier: .gregorian)
                        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
//                        dateComponents.timeZone = .current
                        dateComponents.calendar = Calendar(identifier: .gregorian)
                        
                        datesArray.append(dateComponents)
//                        print(dateComponents)
                    } else {
                        print("Invalid date format")
                    }
                }
                self?.dates.onNext(datesArray)
                
            }
        }
        
    }
    
    
    
    
    
    deinit {
        entriesListener?.remove()
    }
    
    
}
