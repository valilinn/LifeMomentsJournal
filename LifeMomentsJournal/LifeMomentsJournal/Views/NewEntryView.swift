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
    let contentView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hidePlaceholder() {
        guard contentView.textColor == .lightGray else { return }
            contentView.text = nil
            contentView.textColor = .black
    }
    
    private func setViews() {
        //        scrollView.backgroundColor = .orange
        scrollView.backgroundColor = UIColor(named: "mainColor")
        //        containerView.backgroundColor = .cyan
        containerView.backgroundColor = .white
        
        //        doneButton.setImage(UIImage(systemName: "chevron.backward.circle"), for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.tintColor = .white
        doneButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        dateLabel.text = "14 December 2023"
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.textColor = .gray
        
        changeDate.setImage(UIImage(systemName: "calendar.circle"), for: .normal)
        changeDate.tintColor = .brown
        
        titleView.placeholder = "Title"
        titleView.font = UIFont.systemFont(ofSize: 28)
        
        contentView.text = "Write something..."
        contentView.textColor = .lightGray
        contentView.isEditable = true
        contentView.isSelectable = true
        contentView.font = UIFont.systemFont(ofSize: 18)
        contentView.delegate = self
        //        contentView.backgroundColor = .red
        
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            //            make.edges.equalTo(scrollView)
            //            make.width.equalTo(scrollView)
            $0.top.equalTo(scrollView.snp.top).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
//            &0.bottom.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(scrollView)
        }
        
        containerView.addSubview(topOptionsView)
        
        topOptionsView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.width.equalTo(containerView.snp.width)
            $0.height.equalTo(50)
        }
        topOptionsView.backgroundColor = UIColor(named: "mainColor")
        
        containerView.addSubview(doneButton)
        
        doneButton.snp.makeConstraints {
            //            &0.leading.equalTo(imagesCollectionView.snp.leading)
            //            &0.width.height.equalTo(50)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.top.equalTo(topOptionsView.snp.top)
        }
        
        containerView.addSubview(imagesCollectionView)
        
        imagesCollectionView.snp.makeConstraints {
            $0.top.equalTo(doneButton.snp.bottom)
            $0.leading.equalTo(containerView.snp.leading)
            $0.trailing.equalTo(containerView.snp.trailing)
            $0.height.equalTo(170)
        }
        
        containerView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(imagesCollectionView.snp.bottom).offset(16)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
        }
        
        containerView.addSubview(changeDate)
        
        changeDate.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(8)
        }
        
        containerView.addSubview(titleView)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(32)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        
        containerView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(28)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.bottom.equalTo(containerView.snp.bottom)
        }
        
    }
}

extension NewEntryView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        hidePlaceholder()
        // дополнительные действия при изменении текста в UITextView
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        hidePlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write something..."
            textView.textColor = .lightGray
        }
    }
    
}

#Preview {
    NewEntryViewController()
}
