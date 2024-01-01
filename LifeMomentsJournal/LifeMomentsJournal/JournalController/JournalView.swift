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
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "mainColor")
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
//        let layout = UICollectionViewFlowLayout()
        self.tableView = UITableView(frame: .zero)
        addSubview(tableView)
        
        tableView.register(EntriesListCell.self, forCellReuseIdentifier: EntriesListCell.reuseID)
        tableView.backgroundColor = UIColor(named: "mainColor")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    
}

//#Preview {
//    JournalViewController()
//}
