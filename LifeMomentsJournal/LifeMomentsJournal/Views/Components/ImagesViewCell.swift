//
//  ImagesViewCell.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/12/2023.
//

import UIKit

class ImagesViewCell: UICollectionViewCell {
    
    static let reuseID = "ImagesCell"
    
    private let containerView = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        imageView.image = UIImage(named: "morskieOko")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
    }
    
    private func setConstraints() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .green
        
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.height.equalTo(80)
        }
    }
}

#Preview {
    ImagesViewCell()
}

