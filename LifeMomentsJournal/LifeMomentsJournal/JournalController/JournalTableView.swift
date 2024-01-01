////
////  JournalView.swift
////  LifeMomentsJournal
////
////  Created by Валентина Лінчук on 29/11/2023.
////
//
//import UIKit
//import SnapKit
//
//class JournalTableView: UIView {
//    
//    var tableView: UITableView!
//    
//    init() {
//        super.init(frame: .zero)
//        backgroundColor = UIColor(named: "mainColor")
//        setupTableView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupTableView() {
////        let layout = UICollectionViewFlowLayout()
//        self.tableView = UITableView(frame: .zero, style: .grouped)
//        addSubview(tableView)
//        
//        tableView.register(EntriesListCell.self, forCellReuseIdentifier: EntriesListCell.reuseID)
//        tableView.backgroundColor = UIColor(named: "mainColor")
//        
//        tableView.snp.makeConstraints {
////            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
//            $0.edges.equalToSuperview()
//        }
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 150
//    }
//    
//    
//}
//
////#Preview {
////    JournalViewController()
////}