//
//  ImagesViewCell.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/12/2023.
//

import UIKit
import SnapKit
import Kingfisher

class ImagesViewCell: UICollectionViewCell {
    
    static let reuseID = "ImagesCell"
    
    private let containerView = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) { //must be frame, because will not work without it
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: String?) {
        print("Configuring cell with item: \(item)")
        guard let imageURL = item else {
            imageView.image = nil
//            entryImageView.image = UIImage(named: "defaultImage")
            return
        }
        let url = URL(string: imageURL)
        imageView.kf.setImage(with: url)
//        print("Cell is OK - \(item.title), \(item.content)")
    }
    
    private func setViews() {
        imageView.image = UIImage(named: "morskieOko")
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
    }
    
    private func setConstraints() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.width.height.equalTo(200)
        }
        
       
    }
}

//#Preview {
//    ImagesViewController()
//}
