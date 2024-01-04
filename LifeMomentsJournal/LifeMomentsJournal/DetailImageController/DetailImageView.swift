//
//  DetailImageView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/01/2024.
//

import Foundation
import UIKit
import SnapKit

class DetailImageView: UIView {
    
    private let containerView = UIView()
    let imageView = UIImageView()
    let closeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(image: String) {
        let url = URL(string: image)
        imageView.kf.setImage(with: url)
    }
    
    private func setupView() {
        containerView.backgroundColor = .black
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "morskieOko")
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
    }
    
    private func setConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
//            $0.centerY.equalTo(containerView.snp.centerY)
//            $0.centerX.equalTo(containerView.snp.centerX)
            $0.edges.equalTo(containerView.snp.edges)
        }
        
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(70)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
    
    
}

//#Preview {
//    DetailImageViewController()
//}
