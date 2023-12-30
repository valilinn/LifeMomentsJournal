//
//  DetailEntryCollectionView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 06/12/2023.
//

import Foundation
import SnapKit

class DetailEntryCollectionView: UIView {
    
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
        
        collectionView.register(DetailEntryImagesViewCell.self, forCellWithReuseIdentifier: DetailEntryImagesViewCell.reuseID)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

