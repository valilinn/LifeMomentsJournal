//
//  NewEntryImagesView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 05/12/2023.
//

import Foundation
import SnapKit

class NewEntryCollectionView: UIView {
    
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.red
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        
        collectionView.register(NewEntryImagesViewCell.self, forCellWithReuseIdentifier: NewEntryImagesViewCell.reuseID)
//        collectionView.backgroundColor = UIColor.brown
        collectionView.backgroundColor = UIColor.white
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
