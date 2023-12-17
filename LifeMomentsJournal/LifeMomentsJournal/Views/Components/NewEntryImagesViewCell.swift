//
//  NewEntryImagesViewCell.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/12/2023.
//

import UIKit
import SnapKit

class NewEntryImagesViewCell: UICollectionViewCell {
    
    static let reuseID = "ImageCell"
    
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
        imageView.image = UIImage(systemName: "photo.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
    }
    
    private func setConstraints() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        containerView.backgroundColor = .green
        containerView.backgroundColor = .white
        
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.centerY.equalTo(containerView.snp.centerY)
//            $0.height.equalTo(300)
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
    }
}

//#Preview {
//    NewEntryImagesViewCell()
//}

