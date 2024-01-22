//
//  CalendarViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 17/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class CalendarViewController: UIViewController {
    
    private let calendarView = CalendarView()
    private let viewModel = CalendarViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        navigationController?.navigationBar.prefersLargeTitles = true
        calendarView.calendarObject.delegate = self
        setBinds()
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.calendarObject.selectionBehavior = dateSelection
    }
    
    private func setBinds() {
        viewModel.dates
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] decoratedDates in
                if decoratedDates == [] {
                    print("NIL")
                } else {
                    print("MY DATES FROM ENTRIES---\(decoratedDates.count)")
                    decoratedDates.forEach{print("date = \($0.date), year = \($0.year)")}
                    self?.calendarView.calendarObject.reloadDecorations(forDateComponents: decoratedDates, animated: true)
                }
            }).disposed(by: bag)
        viewModel.getDates()
    }
    
    
}
    
extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        var decoration: UICalendarView.Decoration?
        print("DATES FROM CALENDAR---\(dateComponents.date)")
        guard let decoratedDates = try? viewModel.dates.value() else { return nil }
        print("MY DATES---\(decoratedDates.count)")
            if let filteredDates = decoratedDates.filter({ $0.date == dateComponents.date }).first {
                print("Sorted-----\(filteredDates)")
                return .default(color: .gray, size: .medium)
            
        }
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents)
    }
    
   
   
}
