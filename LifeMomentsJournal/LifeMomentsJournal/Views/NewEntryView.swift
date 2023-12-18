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
    
//    let doneButton = UIButton()
    let dateLabel = UILabel()
    let changeDate = UIButton()
    let titleView = UITextField()
    let contentView = UITextView()
    let addImagesButton = UIButton()
    let saveEntryButton = UIButton()
    
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
        
//        doneButton.setTitle("Done", for: .normal)
//        doneButton.tintColor = .white
//        doneButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        dateLabel.text = CurrentDate().date
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
        
        addImagesButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        addImagesButton.imageView?.tintColor = .black
//        addImagesButton.backgroundColor = .red
        addImagesButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 40), forImageIn: .normal)
        
        saveEntryButton.setTitle("Save", for: .normal)
        saveEntryButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        saveEntryButton.backgroundColor = UIColor(named: "saveButton")
        saveEntryButton.layer.cornerRadius = 10
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
        
        containerView.addSubview(imagesCollectionView)
        
        imagesCollectionView.snp.makeConstraints {
//            $0.top.equalTo(doneButton.snp.bottom)
            $0.top.equalTo(containerView.snp.top)
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
        
        
        contentView.addSubview(addImagesButton)
        contentView.addSubview(saveEntryButton)
        containerView.addSubview(contentView)
        
        addImagesButton.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(32)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.width.equalTo(60)
        }
        
        saveEntryButton.snp.makeConstraints {
            $0.trailing.equalTo(containerView.snp.trailing).offset(-32)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.width.equalTo(130)
            $0.height.equalTo(40)
        }
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

//#Preview {
//    NewEntryViewController()
//}
