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
        backgroundColor = UIColor.blue
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        
        collectionView.register(ImagesViewCell.self, forCellWithReuseIdentifier: ImagesViewCell.reuseID)
        collectionView.backgroundColor = UIColor(named: "mainColor")
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
