//
//  ViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 21/11/2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthenticationViewController: UIViewController {
    
    private let authModel = AuthenticationService()
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let authImage = UIImageView()
    private let authButton = UIButton()
    private var authButtonTitle = UILabel()
//    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillViews()
        setViews()
        setLoginButton()
        setConstraints()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerAuthStateHandler()
        
//        handle = Auth.auth().addStateDidChangeListener { auth, user in
//          // ...
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Auth.auth().removeStateDidChangeListener(authStateHandler!)
    }

    private func registerAuthStateHandler() {
        if authStateHandler == nil {
          authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
//            self.user = user
              self.authModel.state = user == nil ? .signedOut : .signedIn
              print(user?.email)
              self.authModel.saveToUserDefaults()
            print("OK")
          }
        } else {
            print("NOT NIL")
        }
        
      }
    
    @objc
    private func loginWithGoogle() {
        authModel.signIn(vc: self) { [weak self] success in
            self?.present(TabBarViewController(), animated: true)
        }
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
    
    private func setLoginButton() {
        authButton.addTarget(self, action: #selector(loginWithGoogle), for: .touchUpInside)
    }
    
    private func setConstraints() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(200)
            make.leading.equalTo(containerView.snp.leading).offset(34)
            make.trailing.equalTo(containerView.snp.trailing).offset(-35) //відступ для норм переносу строки
        }
        
        containerView.addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing).offset(-20) //відступ для норм переносу строки
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

