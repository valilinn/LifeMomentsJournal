//
//  CreateEntryView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit
import SnapKit

class CreateEntryView: UIView {
    
    var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "mainColor")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        
        containerView.backgroundColor = .cyan
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
        
        
    
    }
    
   
    
}

#Preview {
    CreateEntryViewController()
}
