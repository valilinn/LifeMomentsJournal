//
//  CalendarView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 17/01/2024.
//

import UIKit
import SnapKit

class CalendarView: UIView {
    
    var tableViewHeightConstraint: Constraint?
    let calendarObject = UICalendarView()
    let tableView = CalendarTableView()
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "mainColor")
        containerView.backgroundColor = UIColor(named: "mainColor")
        tableView.backgroundColor = .red
        setupCalendar()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCalendar() {
        calendarObject.calendar = Calendar(identifier: .gregorian)
        calendarObject.locale = .current
        calendarObject.fontDesign = .rounded
        calendarObject.layer.cornerRadius = 12
        calendarObject.backgroundColor = .white
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        containerView.addSubview(calendarObject)
        calendarObject.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(containerView.snp.leading).offset(8)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-8)
            $0.height.equalTo(425)
        }
        
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(calendarObject.snp.bottom).offset(28)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-16)
            tableViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }
    
}

//#Preview {
//    CalendarViewController()
//}
