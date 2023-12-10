//
//  EntriesListCell.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 29/11/2023.
//

import UIKit
import SnapKit

class EntriesListCell: UICollectionViewCell {
    
    static let reuseID = "EntriesCell" //переиспользуемый идентификатор
    
    private let containerView = UIView()
    let dateLabel = UILabel()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let entryImageView = UIImageView()
    
    override init(frame: CGRect) { //must be frame, because will not work without it
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        dateLabel.text =
"""
MON
14
"""
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        
        titleLabel.text = "Name of Entry"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 2
        
        contentLabel.text = "Lorem Ipsum Loremmm Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem IpsumLorem Ipsum Lorem Ipsum and typesetting industry. Lorem Ipsum is simply dummy text."
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        contentLabel.numberOfLines = 3
        entryImageView.image = UIImage(named: "morskieOko")
        entryImageView.contentMode = .scaleToFill
        entryImageView.layer.cornerRadius = 8 
        entryImageView.layer.masksToBounds = true
        
    }
    
    private func setConstraints() { 
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.backgroundColor = .white
        
        containerView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.width.equalTo(45)
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        
        containerView.addSubview(stack)
        containerView.addSubview(entryImageView)
        
        stack.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(16)
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.trailing.equalTo(entryImageView.snp.leading).offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentLabel.snp.top).offset(-6)
        }
        
        
        entryImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.centerY.equalTo(stack.snp.centerY)
            $0.width.height.equalTo(80)
        }
    }
    
}

//#Preview {
//    EntriesListCell()
//}
