//
//  ImagesView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/12/2023.
//

import UIKit
import SnapKit

class ImagesView: UIView {
    
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "mainColor")
//        backgroundColor = .white
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
        collectionView.backgroundColor = .white
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
}
