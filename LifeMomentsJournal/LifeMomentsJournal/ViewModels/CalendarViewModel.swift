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
    
    var dates = BehaviorSubject(value: [DateComponents]())
    var entries = BehaviorSubject(value: [Entry]())
    var selectedDate = BehaviorSubject(value: String())
    var selectedEntries = BehaviorSubject(value: [Entry]())
   
//    let dataArray = [Entry(userId: "01", date: "14.02.2024", title: "TEST1"), Entry(userId: "01", date: "14.02.2024", title: "TEST2")]
//    
//    let data: BehaviorRelay<[Entry]> = BehaviorRelay(value: [])
//       
//       func fetchData() {
//           // Здесь вы можете добавить логику для загрузки данных в массив
//           // Например, data.accept(новые_данные)
//           data.accept(dataArray)
//       }
    
    private var entriesListener: ListenerRegistration?
    
    func getEntries() {
        guard let userId = AuthenticationService.shared.userId else { return }
        entriesListener?.remove()
        
        FirestoreAndStorageService.shared.listenForEntries(for: userId) { [weak self] entries, error in
            if let error = error {
                print("Error fetching entries: \(error)")
            } else if let entries = entries {
                self?.entries.onNext(entries)
                self?.getDates(entries: entries)
            }
        }
        
    }
    
    private func getDates(entries: [Entry]) {
        var datesArray = [DateComponents]()
        
        for (index, entry) in entries.enumerated() {
            let dateString = entry.date
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            if let date = dateFormatter.date(from: dateString) {
                let calendar = Calendar(identifier: .gregorian)
                var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
                dateComponents.calendar = Calendar(identifier: .gregorian)
//                print("ViewModel = \(dateComponents)")
                //check if array already contains the same date, because the date can't repeat, the app will crush
                if !datesArray.contains(dateComponents) {
                    datesArray.append(dateComponents)
                }
            } else {
                print("Invalid date format")
            }
            self.dates.onNext(datesArray)
        }
    }
    
    func getSelectedDate(date: DateComponents?) {
        guard let date = date else { return }
        guard let dates = try? dates.value() else { return }
        
        if let filteredDate = dates.filter({ $0.date == date.date }).first {
            guard let selectedDate = filteredDate.date else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // Выберите нужный вам формат даты
            let selectedDateString: String = dateFormatter.string(from: selectedDate)
            self.selectedDate.onNext(selectedDateString)
            getEntriesFromSelectedDate()
            print("I have entries from this day \(filteredDate.date), selected date string is \(selectedDateString)")
        } else {
            self.selectedDate.onNext("")
            self.selectedEntries.onNext([])
            print("I don't have any entries from this day")
        }
    }
    
    private func getEntriesFromSelectedDate() {
        guard let selectedDate = try? selectedDate.value(), !selectedDate.isEmpty, let entries = try? entries.value() else {
            print("Cant filter entries from selectedDate")
            self.selectedEntries.onNext([])
            return
        }
        let filteredEntries = entries.filter({ $0.date.prefix(10) == selectedDate.prefix(10) })
        print("rfrvffv \(entries.first?.date.prefix(10)), \(selectedDate.prefix(10))")
        selectedEntries.onNext(filteredEntries)
        print("Entries from this day: \(try? selectedEntries.value())")
    }
    
//    func clearData() {
//        dates.onNext([])
//        entries.onNext([])
//        selectedDate.onNext("")
//        selectedEntries.onNext([])
//    }

    
    deinit {
        entriesListener?.remove()
    }
    
    
}
