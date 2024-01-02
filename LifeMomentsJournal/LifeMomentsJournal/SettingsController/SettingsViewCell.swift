//
//  SettingsViewCell.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 02/01/2024.
//

import Foundation
import SnapKit
import Kingfisher

class SettingsViewCell: UITableViewCell {
    
    static let reuseID = "SettingsViewCell"
    
    private let containerView = UIView()
    let settingIcon = UIImageView()
    let settingName = UILabel()
    let settingChevron = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: Settings) {
        settingIcon.image = UIImage(systemName: item.icon)
        settingName.text = item.title
        settingChevron.image = UIImage(systemName: item.chevron)
    }
    
    private func setViews() {
        settingIcon.image = UIImage(systemName: "pencil.line")
        settingName.text = "Some settings.."
        settingChevron.image = UIImage(systemName: "chevron.right")
//        containerView.backgroundColor = .green
    }
    
    private func setConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(settingIcon)
        settingIcon.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
        }
        
        containerView.addSubview(settingName)
        settingName.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.leading.equalTo(settingIcon.snp.trailing).offset(16)
        }
        
        containerView.addSubview(settingChevron)
        settingChevron.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        
    }
    
    
    
}
