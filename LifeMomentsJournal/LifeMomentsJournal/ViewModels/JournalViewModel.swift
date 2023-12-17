//
//  JournalViewModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 16/12/2023.
//

import Foundation
import RxSwift
import RxCocoa

class JournalViewModel {
    var entries = BehaviorSubject(value: [Entry]())
    var entriesArray = [Entry]()
    
    func createEntry(entry: Entry) {
        entriesArray.insert(entry, at: 0)
        self.entries.onNext(entriesArray)
        print("My notes - \(try? entries.value())")
    }
}
