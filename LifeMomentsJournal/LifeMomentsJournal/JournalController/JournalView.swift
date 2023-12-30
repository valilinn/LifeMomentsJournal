//
//  JournalView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 29/11/2023.
//

import UIKit
import SnapKit

class JournalView: UIView {
    
    var collectionView: UITableView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "mainColor")
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UITableView(frame: .zero)
        addSubview(collectionView)
        
        collectionView.register(EntriesListCell.self, forCellReuseIdentifier: EntriesListCell.reuseID)
        collectionView.backgroundColor = UIColor(named: "mainColor")
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    
}

//#Preview {
//    JournalViewController()
//}
