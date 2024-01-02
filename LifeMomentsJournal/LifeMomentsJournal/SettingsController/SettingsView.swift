//
//  SettingsView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 02/01/2024.
//

import Foundation
import SnapKit
import Kingfisher

class SettingsView: UIView {
    
    private let containerView = UIView()
    private let userContainerView = UIView()
    private let settingsContainerView = UIView()
    let settingsTableView = SettingsTableView()
    
    let imageView = UIImageView()
    let userNameLabel = UILabel()
    let logo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "mainColor")
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUserPhoto(photoURL: String?) {
        guard let photoURL = photoURL else {
            imageView.image = UIImage(named: "user")
            return
        }
        let url = URL(string: photoURL)
        imageView.kf.setImage(with: url)
    }
    
    func configureUserName(name: String?) {
        guard let name = name else { return }
        userNameLabel.text = name
    }
    
    private func setViews() {
        imageView.image = UIImage(named: "user")
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        
        userNameLabel.text = "Mark Twain"
        userNameLabel.numberOfLines = 0
        userNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        userContainerView.backgroundColor = .white
        userContainerView.layer.cornerRadius = 10
        userContainerView.layer.masksToBounds = true
        
        settingsContainerView.backgroundColor = .white
        settingsContainerView.layer.cornerRadius = 10
        settingsContainerView.layer.masksToBounds = true
        
        logo.text = "Life \n Moments Journal"
        logo.numberOfLines = 0
        logo.textAlignment = .center
        logo.textColor = .lightGray
    }
    
    private func setConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(userContainerView)
        userContainerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.height.equalTo(150)
        }
        
        userContainerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerY.equalTo(userContainerView.snp.centerY)
            $0.leading.equalTo(userContainerView.snp.leading).offset(16)
            $0.height.width.equalTo(100)
        }
        
        userContainerView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
        }
        
        containerView.addSubview(settingsContainerView)
        settingsContainerView.snp.makeConstraints {
            $0.top.equalTo(userContainerView.snp.bottom).offset(80)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.height.equalTo(180)
        }
        
        settingsContainerView.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints {
            $0.top.equalTo(settingsContainerView.snp.top)
            $0.leading.equalTo(settingsContainerView.snp.leading)
            $0.trailing.equalTo(settingsContainerView.snp.trailing)
            $0.height.equalTo(180)
        }
        
        containerView.addSubview(logo)
        logo.snp.makeConstraints {
//            $0.top.equalTo(settingsContainerView.snp.bottom).offset(50)
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.top.equalTo(settingsContainerView.snp.bottom).offset(70)
        }
    }
    
    
    
    
    
}
