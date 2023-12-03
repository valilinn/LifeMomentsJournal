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
        titleLabel.numberOfLines = 0
        
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
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .white
        
        containerView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(45)
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        
        containerView.addSubview(stack)
        containerView.addSubview(entryImageView)
        
        stack.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(16)
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.trailing.equalTo(entryImageView.snp.leading).offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentLabel.snp.top).offset(-6)
        }
        
        
        entryImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.centerY.equalTo(stack.snp.centerY)
            make.width.height.equalTo(80)
        }
    }
    
}

//#Preview {
//    EntriesListCell()
//}
