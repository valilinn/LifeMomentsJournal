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
    let imagesCollectionView = NewEntryCollectionView()
    
    let doneButton = UIButton()
    let dateLabel = UILabel()
    let titleLabel = UILabel()
    let textView = UITextView()
    
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
        containerView.backgroundColor = .cyan
        
//        doneButton.setTitle("Done", for: .normal)
        doneButton.setImage(UIImage(systemName: "chevron.backward.circle"), for: .normal)
        doneButton.tintColor = .white
//        doneButton.backgroundColor = .red
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.backgroundColor = .orange
        
        scrollView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide.snp.top) // Устанавливаем верхний constraint, игнорируя safe area
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
                make.width.equalTo(scrollView)
                make.height.equalTo(scrollView)
            }
        
        containerView.addSubview(imagesCollectionView)
        
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(300)
        }
        
        containerView.addSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(imagesCollectionView.snp.leading)
            make.width.height.equalTo(50)
        }
      
    }
    
    
   
    
    
}

#Preview {
    NewEntryViewController()
}
