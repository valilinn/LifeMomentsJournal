//
//  CalendarViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 17/01/2024.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private let calendarView = CalendarView()
    private let viewModel = CalendarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        calendarView.calendarObject.delegate = self
        setNavBar()
        viewModel.setSelectedDates()
    }
    
    private func setNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }

   

}

extension CalendarViewController: UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
