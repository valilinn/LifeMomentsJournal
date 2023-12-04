//
//  NewEntryView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit
import SnapKit

class NewEntryView: UIView {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        setViews()
        setConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
//        collectionView.register(EntriesListCell.self, forCellWithReuseIdentifier: EntriesListCell.reuseID)
//        collectionView.backgroundColor = UIColor(named: "mainColor")
        
        
    }
    
    private func setViews() {
        containerView.backgroundColor = .cyan
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        containerView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.bottom.equalTo(100)
        }
       
        
        
  
    }
    
   
    
}

//#Preview {
//    NewEntryViewController()
//}
