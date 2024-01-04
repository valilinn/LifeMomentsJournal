//
//  SettingsTableView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 02/01/2024.
//

import Foundation
import SnapKit

class SettingsTableView: UIView {
    
    var tableView: UITableView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: .zero)
        addSubview(tableView)
        
        tableView.register(SettingsViewCell.self, forCellReuseIdentifier: SettingsViewCell.reuseID)
        tableView.isScrollEnabled = false
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
