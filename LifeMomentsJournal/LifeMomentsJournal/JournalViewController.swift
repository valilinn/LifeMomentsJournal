//
//  JournalViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 28/11/2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class JournalViewController: UIViewController {
    
    var authModel = AuthenticationModel()
    var textView = TextView()
    
    var containerView = UIView()
    var signOutButton = UIButton()
    var signOutButtonTitle = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Life Moments Journal"
        view.backgroundColor = .cyan
        navigationController?.navigationBar.prefersLargeTitles = true
        configureUIElements()
    }
    
    func configureUIElements() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = UIColor(named: "mainColor")
        
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.tintColor = .white
        signOutButton.backgroundColor = .red

        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)

        containerView.addSubview(signOutButton)

        signOutButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)  
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        
    }
    
    @objc
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            authModel.state = .signedOut
            authModel.saveToUserDefaults()
            print("log out")
        } catch {
            print(error.localizedDescription)
        }
    }


}
