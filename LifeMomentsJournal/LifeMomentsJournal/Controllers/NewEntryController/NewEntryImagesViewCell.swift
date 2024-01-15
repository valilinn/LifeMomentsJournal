//
//  NewEntryImagesViewCell.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/12/2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
//import Kingfisher

class NewEntryImagesViewCell: UICollectionViewCell {
    
    let deleteImageButton = UIButton()
    let deleteButtonTappedSubject = PublishSubject<Void>()
    var bag = DisposeBag()
    
    static let reuseID = "ImageCell"
    
    private let containerView = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setButton()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(with imageURL: String?) {
//        guard let imageURL = imageURL, !imageURL.isEmpty else {
//            imageView.image = UIImage(named: "defaultImage")
//            return
//        }
//        let url = URL(string: imageURL)
//        imageView.kf.setImage(with: url)
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //Reset disposeBag when reusing a cell
        bag = DisposeBag()
    }
    
    @objc
    func deleteButtonTapped() {
        deleteButtonTappedSubject.onNext(())
      }

    private func setViews() {
        containerView.backgroundColor = .white
        
        imageView.image = UIImage(named: "defaultImage")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
    }
    
    private func setButton() {
        deleteImageButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteImageButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteImageButton.tintColor = .white
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
            $0.width.equalTo(containerView)
            $0.height.equalTo(containerView)
        }
        
        containerView.addSubview(deleteImageButton)
        deleteImageButton.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(4)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-4)
        }
    }
}



//#Preview {
//    NewEntryImagesViewCell()
//}

