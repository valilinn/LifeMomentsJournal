//
//  DetailEntryView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 06/12/2023.
//

import UIKit
import SnapKit

class DetailEntryView: UIView {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    let imagesCollectionView = DetailEntryCollectionView()
//    private let pageControl = UIPageControl()
    
    var dateLabel = UILabel()
    var titleLabel = UILabel()
    var contentView = UITextView()
    
    var collectionViewHeightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDetailView(entry: Entry) {
        dateLabel.text = entry.date
        titleLabel.text = entry.title
        contentView.text = entry.content
    }
    
    private func setViews() {
        scrollView.backgroundColor = .orange
        containerView.backgroundColor = .white
        contentView.backgroundColor = .white
        
        dateLabel.text = "2023-12-21 12:56"
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.textColor = .gray
        
        titleLabel.text = "Title"
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        
        contentView.text = "Write something..."
        contentView.textColor = .black
        contentView.isEditable = false
        contentView.font = UIFont.systemFont(ofSize: 18)
//        contentView.isScrollEnabled = false
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.height.equalTo(scrollView)
            
        }
        
        containerView.addSubview(imagesCollectionView)
        imagesCollectionView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(containerView.snp.leading)
            $0.trailing.equalTo(containerView.snp.trailing)
            collectionViewHeightConstraint = $0.height.equalTo(300).constraint
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(imagesCollectionView.snp.bottom).offset(16)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(32)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-16)
        }
      
    }
    
    
   
    
    
}

//#Preview {
//    DetailEntryViewController()
//}

