//
//  ViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 21/11/2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthenticationViewController: UIViewController {
    
    private let authenticationView = AuthenticationView()
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = authenticationView
        view.backgroundColor = .systemBackground
        setLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerAuthStateHandler()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Auth.auth().removeStateDidChangeListener(authStateHandler!)
    }
    
    private func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                AuthenticationService.shared.state = user == nil ? .signedOut : .signedIn
                print(user?.email ?? "")
                AuthenticationService.shared.saveToUserDefaults()
            }
        } else {
            print("authStateHandler is not nil")
        }
        
    }
    private func setLoginButton() {
        authenticationView.authButton.addTarget(self, action: #selector(loginWithGoogle), for: .touchUpInside)
    }
    
    @objc
    private func loginWithGoogle() {
        AuthenticationService.shared.signIn(vc: self) { [weak self] success in
            print("Success is \(success)")
            if success {
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            } else {
                print("Login error")
                return
            }
        }
    }
    
}

