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
    
    let abc = [DateComponents(calendar: Calendar(identifier: .gregorian), year: 2024, month: 1, day: 26)]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        navigationController?.navigationBar.prefersLargeTitles = true
        calendarView.calendarObject.delegate = self
        viewModel.getDates()
        setBinds()
    }
    
    private func setBinds() {
//        viewModel.dates
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { decoratedDates in
////                print("Decorated dates is \(decoratedDates)")
//                
//            })
//            .disposed(by: bag)
        
        // Запустим получение данных
//        viewModel.getDates()
    
}


   

}

extension CalendarViewController: UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        var decoration: UICalendarView.Decoration?
        //        guard let decoratedDates = try? viewModel.dates.value() else { return nil }
        //        print("jnln\(decoratedDates)")
        viewModel.dates
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { decoratedDates in
                if decoratedDates == [] {
                    
                } else {
                    print("MY DATES---\(decoratedDates[0].date)")
                    print("DATES FROM DELEDATE---\(dateComponents.date)")
                    DispatchQueue.main.async {
                        if let filteredDates = decoratedDates.filter({ $0.date == dateComponents.date }).first {
                        
                            print("Sorted-----\(filteredDates)")
                            decoration = .default()
                    }
                    
                }
               
                    
                }
                
            }).disposed(by: bag)
        
        return decoration
    }
}
