//
//  JournalView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 29/11/2023.
//

import UIKit
import SnapKit

class JournalView: UIView {
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupCollectionView()
    }
    
    
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBlue
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    JournalViewController()
}
