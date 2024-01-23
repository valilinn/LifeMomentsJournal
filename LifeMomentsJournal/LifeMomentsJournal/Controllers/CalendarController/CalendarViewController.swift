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
    
    private let tableViewHeight: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        navigationController?.navigationBar.prefersLargeTitles = true
        calendarView.calendarObject.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.calendarObject.selectionBehavior = dateSelection
        calendarView.tableView.tableView.delegate = self
        bindTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getDates()
        bindCalendar()
    }
    
    private func bindCalendar() {
        viewModel.dates
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] decoratedDates in
                if decoratedDates == [] {
                    print("NIL")
                } else {
//                    print("MY DATES FROM viewModel---\(decoratedDates)")
                    decoratedDates.forEach{print("date = \($0.date), year = \($0.year)")}
                    DispatchQueue.main.async {
                        self?.calendarView.calendarObject.reloadDecorations(forDateComponents: decoratedDates, animated: true)
                    }
                        
                }
            }).disposed(by: bag)
    }
    
    private func bindTableView() {
//        viewModel.entries
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] _ in
//                self?.calendarView.tableView.tableView.reloadData()
//            })
//            .disposed(by: bag)
        
//        viewModel.entries
//            .observe(on: MainScheduler.instance)
//            .bind(to: calendarView.tableView.tableView.rx.items(cellIdentifier: EntriesListCell.reuseID, cellType: EntriesListCell.self)) { index, entry, cell in
//                
//                
//            }
    }
    
    
}
    
extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//        print("DATES FROM CALENDAR---\(dateComponents.date)")
        guard let decoratedDates = try? viewModel.dates.value() else { return nil }
        print("MY DATES from delegate---\(decoratedDates)")
            if let filteredDates = decoratedDates.filter({ $0.date == dateComponents.date }).first {
//                print("Sorted-----\(filteredDates)")
                return .default(color: .gray, size: .medium)
            
        }
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let selectedDate = dateComponents else { return }
        viewModel.selectedDate.onNext(selectedDate)
        print(dateComponents)
    }
    
}

extension CalendarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
        cell.contentView.frame = cell.contentView.frame.inset(by: inset)
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
