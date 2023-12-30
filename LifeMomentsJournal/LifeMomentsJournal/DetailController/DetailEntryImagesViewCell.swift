//
//  DetailEntryImagesViewCell.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 06/12/2023.
//

import UIKit
import SnapKit
import Kingfisher

class DetailEntryImagesViewCell: UICollectionViewCell {
    
    static let reuseID = "DetailEntryImageCell"
    
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
    
    func configure(with imageURL: String?) {
        guard let imageURL = imageURL else {
            imageView.image = nil
            return
        }
        let url = URL(string: imageURL)
        imageView.kf.setImage(with: url)

    }
    
    private func setViews() {
        imageView.image = UIImage(named: "morskieOko")
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setConstraints() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .green
        
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
//            make.height.equalTo(300)
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height)
        }
    }
}

//#Preview {
//    DetailEntryImagesViewCell()
//}

