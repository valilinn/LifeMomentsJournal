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
    
    var containerView = UIView()
    var textView = TextView()
    var dateLabel = UILabel()
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    let entryImageView = UIImageView()
    
    override init(frame: CGRect) { //must be frame, because will not work without it
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        dateLabel = textView.textLabel(
            text:
"""
MON
14
""", fontSize: 18, weight: .light)
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        
        titleLabel = textView.textLabel(text: "Name of Entry Name of Entry Name of Entry Name of Entry ", fontSize: 16, weight: .bold)
        titleLabel.numberOfLines = 0
        contentLabel = textView.textLabel(text: "Lorem Ipsum Loremmm Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem IpsumLorem Ipsum Lorem Ipsum and typesetting industry. Lorem Ipsum is simply dummy text.", fontSize: 14, weight: .light)
        contentLabel.numberOfLines = 3
        entryImageView.image = UIImage(named: "study")
        entryImageView.contentMode = .scaleAspectFill
        
        
    }
    
    func setConstraints() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .cyan
        
        containerView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(50)
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
            make.bottom.equalTo(contentLabel.snp.top).offset(-8)
        }
        
        
        entryImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.centerY.equalTo(stack.snp.centerY)
            make.width.height.equalTo(70)
        }
    }
    
}

#Preview {
    EntriesListCell()
}
