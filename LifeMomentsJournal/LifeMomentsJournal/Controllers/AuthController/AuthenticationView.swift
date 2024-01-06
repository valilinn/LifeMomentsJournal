//
//  AuthenticationView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/01/2024.
//

import Foundation
import UIKit
import SnapKit

class AuthenticationView: UIView {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let authImage = UIImageView()
    let authButton = UIButton()
    private let authButtonTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fillViews()
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillViews() {
        titleLabel.text = "May your memories and moments in life always be private"
        subTitleLabel.text = "Sign in with your Google account and be sure that all your thoughts will always be available only to you."
        authImage.image = UIImage(named: "socialGoogleIcon")
        authButton.setTitle("Login with Google", for: .normal)
        authButtonTitle.text = "Login with Google"
    }
    
    private func setViews() {
        containerView.backgroundColor = UIColor(named: "mainColor")
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        
        subTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        subTitleLabel.textColor = UIColor.white
        subTitleLabel.numberOfLines = 0
        
        authImage.contentMode = .scaleAspectFit
        
        authButton.setTitleColor(.white, for: .normal)
        authButton.tintColor = .white
        
        authButtonTitle.font = UIFont.systemFont(ofSize: 20, weight: .light)
        authButtonTitle.textColor = UIColor.white
    }
    
    private func setConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(200)
            make.leading.equalTo(containerView.snp.leading).offset(34)
            make.trailing.equalTo(containerView.snp.trailing).offset(-35)
        }
        
        containerView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing).offset(-20)
        }
        
        containerView.addSubview(authImage)
        authImage.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(80)
            make.leading.equalTo(subTitleLabel.snp.leading)
            make.width.height.equalTo(60)
        }
       
        containerView.addSubview(authButton)
        authButton.snp.makeConstraints { make in
            make.centerY.equalTo(authImage.snp.centerY)
            make.leading.equalTo(authImage.snp.trailing).offset(34)
        }
        
        authButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(80)
            make.leading.equalTo(subTitleLabel.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing).offset(-34)
        }
        
        authButton.addSubview(authButtonTitle)

    }
}
