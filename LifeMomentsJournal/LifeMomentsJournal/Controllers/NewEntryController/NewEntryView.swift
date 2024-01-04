//
//  NewEntryView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit
import SnapKit

class NewEntryView: UIView {
    
    private let containerView = UIView()
    let imagesCollectionView = NewEntryCollectionView()
    
    let dateLabel = UILabel()
    let titleView = UITextField()
    let contentView = UITextView()
    let addImagesButton = UIButton()
    let saveEntryButton = UIButton()
    private let defaultText = "Write something..."
    
    var collectionViewHeightConstraint: Constraint?
    var dateTopConstraint: Constraint?
    var titleTopConstraint: Constraint?
    var contentViewBottomConstraint: Constraint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        fillViews()
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
    
    private func fillViews() {
        titleView.placeholder = "Title"
        contentView.text = defaultText
        addImagesButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        saveEntryButton.setTitle("Save", for: .normal)
    }
    
    private func setViews() {
        dateLabel.text = CurrentDate().date
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.textColor = .gray
        
        titleView.font = UIFont.systemFont(ofSize: 28)
        
        contentView.textColor = .lightGray
        contentView.isEditable = true
        contentView.isSelectable = true
        contentView.font = UIFont.systemFont(ofSize: 18)
        contentView.delegate = self
        
        addImagesButton.imageView?.tintColor = .black
        addImagesButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 40), forImageIn: .normal)
        
        saveEntryButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        saveEntryButton.backgroundColor = UIColor(named: "saveButton")
        saveEntryButton.layer.cornerRadius = 10
    }
    
    private func setConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(imagesCollectionView)
        imagesCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            $0.leading.equalTo(containerView.snp.leading)
            $0.trailing.equalTo(containerView.snp.trailing)
            collectionViewHeightConstraint = $0.height.equalTo(154).constraint
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            dateTopConstraint = $0.top.equalTo(imagesCollectionView.snp.bottom).offset(16).constraint
            $0.leading.equalTo(containerView.snp.leading).offset(16)
        }
        
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints {
            titleTopConstraint = $0.top.equalTo(dateLabel.snp.bottom).offset(32).constraint
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        
        containerView.addSubview(addImagesButton)
        addImagesButton.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(32)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-32)
            $0.width.equalTo(60)
        }
        
        containerView.addSubview(saveEntryButton)
        saveEntryButton.snp.makeConstraints {
            $0.trailing.equalTo(containerView.snp.trailing).offset(-32)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-32)
            $0.width.equalTo(130)
            $0.height.equalTo(40)
        }
        
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(28)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            contentViewBottomConstraint = $0.bottom.equalTo(addImagesButton.snp.top).offset(-8).constraint
        }
    }
}

extension NewEntryView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        hidePlaceholder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        hidePlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = defaultText
            textView.textColor = .lightGray
        }
    }
}

//#Preview {
//    NewEntryViewController()
//}
