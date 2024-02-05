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
        viewModel.getEntries()
        bindCalendar()
    }
    
   
    
    private func bindCalendar() {
        viewModel.dates
            .observe(on: MainScheduler.instance)
            .take(until: self.rx.deallocated)
            .subscribe(onNext: { [weak self] decoratedDates in
                if decoratedDates == [] {
                } else {
                    DispatchQueue.main.async {
                        self?.calendarView.calendarObject.reloadDecorations(forDateComponents: decoratedDates, animated: true)
                    }
                        
                }
            }).disposed(by: bag)
    }
    
    private func bindTableView() {
        
        
        viewModel.selectedEntries
            .observe(on: MainScheduler.instance)
            .take(until: self.rx.deallocated)
            .subscribe(onNext: { [weak self] _ in
                let calculatedHeight = self?.calculateTableViewHeight() ?? 0
                self?.calendarView.tableViewHeightConstraint?.update(offset: calculatedHeight)
                
                self?.calendarView.tableView.tableView.reloadData()
                print("Reload CalendarTableView")
            })
            .disposed(by: bag)
        
        viewModel.selectedEntries
            .observe(on: MainScheduler.instance)
            .bind(to: calendarView.tableView.tableView.rx.items(cellIdentifier: EntriesListCell.reuseID, cellType: EntriesListCell.self)) { index, entry, cell in
                
                DispatchQueue.main.async {
                    cell.configure(with: entry)
                    print("To tableView \(entry.title)")
                }
            }
            .disposed(by: bag)
    }
    
    private func calculateTableViewHeight() -> CGFloat {
        let entries = try? viewModel.selectedEntries.value()
        guard let numberOfRows = entries?.count else { return 0 }
        let rowHeight = 150

        return CGFloat(numberOfRows * rowHeight)
    }
    
    
}
    
extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let decoratedDates = try? viewModel.dates.value() else { return nil }
            if let filteredDates = decoratedDates.filter({ $0.date == dateComponents.date }).first {
                return .default(color: .gray, size: .medium)
            
        }
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let selectedDate = dateComponents else { return }
        viewModel.getSelectedDate(date: selectedDate)
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
