//
//  NewEntryView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit
import SnapKit

class NewEntryView: UIView {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let topOptionsView = UIView()
    let imagesCollectionView = NewEntryCollectionView()
    
    let doneButton = UIButton()
    let dateLabel = UILabel()
    let changeDate = UIButton()
    let titleView = UITextField()
    let contentView = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        scrollView.backgroundColor = .orange
        
//        doneButton.setImage(UIImage(systemName: "chevron.backward.circle"), for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.tintColor = .white
        doneButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        dateLabel.text = "14 December 2023"
        dateLabel.textColor = .gray
        
        changeDate.setImage(UIImage(systemName: "calendar.circle"), for: .normal)
        changeDate.tintColor = .blue
        
        titleView.placeholder = "Title"
        titleView.backgroundColor = .red
        
        contentView.placeholder = "Write something..."
        contentView.backgroundColor = .blue

    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.width.equalTo(scrollView)
            make.top.equalTo(scrollView.snp.top).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        containerView.backgroundColor = .cyan
        
        containerView.addSubview(topOptionsView)
        
        topOptionsView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(8)
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(50)
        }
        topOptionsView.backgroundColor = UIColor(named: "mainColor")
        
        containerView.addSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
//            make.leading.equalTo(imagesCollectionView.snp.leading)
//            make.width.height.equalTo(50)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(topOptionsView.snp.top)
        }
        
        containerView.addSubview(imagesCollectionView)
        
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(170)
        }
        
        containerView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imagesCollectionView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
        }
        
        containerView.addSubview(changeDate)
        
        changeDate.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.leading.equalTo(dateLabel.snp.trailing).offset(8)
        }
        
        containerView.addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        
        containerView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom)
        }
      
    }
    
    
   
    
    
}

#Preview {
    NewEntryViewController()
}