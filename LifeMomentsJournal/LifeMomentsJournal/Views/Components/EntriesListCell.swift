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
    
    func configure(with item: Entry) {
        dateLabel.text = item.date
        titleLabel.text = item.title
        contentLabel.text = "\(item.content)"
        print("Cell is OK - \(item.title), \(item.content)")
    }
    
    private func setViews() {
        dateLabel.text = "14 February 2023"
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        
        titleLabel.text = "Name of Entry"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 2
        
        contentLabel.text = "Lorem Ipsum Loremmm Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem IpsumLorem Ipsum Lorem Ipsum and typesetting industry. Lorem Ipsum is simply dummy text."
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        contentLabel.numberOfLines = 5
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
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, contentLabel, dateLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        
        containerView.addSubview(stack)
        containerView.addSubview(entryImageView)
        
        stack.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.trailing.equalTo(entryImageView.snp.leading).offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentLabel.snp.top).offset(-6)
        }
        
        
        entryImageView.snp.makeConstraints {
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.centerY.equalTo(stack.snp.centerY)
            $0.width.height.equalTo(130)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(16)
        }
    }
    
}

//#Preview {
//    EntriesListCell()
//}
