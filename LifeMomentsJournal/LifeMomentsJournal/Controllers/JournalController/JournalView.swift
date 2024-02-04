//
//  JournalView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 01/01/2024.
//

import UIKit
import SnapKit

class JournalView: UIView {
    
    var tableView: UITableView!
    var headerView = UIView()
    var headerLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "mainColor")
        setupTableView()
        headerView = setupHeaderView()
        tableView.tableHeaderView = headerView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: .zero)
        addSubview(tableView)
        
        tableView.register(EntriesListCell.self, forCellReuseIdentifier: EntriesListCell.reuseID)
        tableView.backgroundColor = .white
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    private func setupHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "mainColor")
        headerLabel.textColor = .white
        headerLabel.font = .italicSystemFont(ofSize: 14)
        headerLabel.numberOfLines = 0

        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            
        }
        headerLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 32
        
        headerView.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        return headerView
    }
    
    
}

//#Preview {
//    JournalViewController()
//}
