//
//  CalendarTableView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 17/01/2024.
//

import Foundation
import SnapKit

class CalendarTableView: UIView {
    
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView = UITableView()
        addSubview(tableView)
        tableView.register(EntriesListCell.self, forCellReuseIdentifier: EntriesListCell.reuseID)
        tableView.backgroundColor = .white
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
}
