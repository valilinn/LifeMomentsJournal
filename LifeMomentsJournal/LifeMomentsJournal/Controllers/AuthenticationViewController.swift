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
    
    var authModel = AuthenticationModel()
    var authStateHandler: AuthStateDidChangeListenerHandle?
    
    var textView = TextView()
    var containerView = UIView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var authImage = UIImageView()
    var authButton = UIButton()
    var authButtonTitle = UILabel()
//    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
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

    func registerAuthStateHandler() {
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
    func loginWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
          guard error == nil else {
            // ...
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
                    
          else {
            // ...
              return
          }
//            print(result?.user.userID)

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let firebaseUser = result?.user
                    print("User\(firebaseUser?.uid) signed in with email \(firebaseUser?.email ?? "unknown")")
//                    self?.authModel.state = .authenticated
//                    self?.authModel.saveToUserDefaults()
                    
                    let newRootController = JournalViewController()
                    let navigationController = UINavigationController(rootViewController: newRootController)
                    navigationController.modalPresentationStyle = .fullScreen
                    self?.present(navigationController, animated: true)
                    
                    
                }
                print("Sign in successful!")
                
              // At this point, our user is signed in
            }

          // ...
        }
    }
    
    func configureUIElements() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = UIColor(named: "mainColor")
        
        titleLabel = textView.textLabel(text: "May your memories and moments in life always be private",fontSize: 24, weight: .medium, color: .white)
        titleLabel.numberOfLines = 0 //переносить текст на інший рядок
        
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(200)
            make.leading.equalTo(containerView.snp.leading).offset(34)
            make.trailing.equalTo(containerView.snp.trailing).offset(-35) //відступ для норм переносу строки
        }
        
        subTitleLabel = textView.textLabel(text: "Sign in with your Google account and be sure that all your thoughts will always be available only to you.",fontSize: 18, weight: .light, color: .white)
        subTitleLabel.numberOfLines = 0 //переносить текст на інший рядок
        
        containerView.addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing).offset(-20) //відступ для норм переносу строки
        }
       
        authImage.image = UIImage(named: "socialGoogleIcon")
        authImage.contentMode = .scaleAspectFit
        
        containerView.addSubview(authImage)
        
        authImage.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(80)
            make.leading.equalTo(subTitleLabel.snp.leading)
            make.width.height.equalTo(60)
        }
        
        authButton.setTitle("Login with Google", for: .normal)
        authButton.setTitleColor(.white, for: .normal)
        authButton.tintColor = .white
       
        authButton.addTarget(self, action: #selector(loginWithGoogle), for: .touchUpInside)

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

        authButtonTitle = textView.textLabel(text: "Login with Google",fontSize: 20, weight: .light, color: .white)
        
        
        authButton.addSubview(authButtonTitle)

    }
    
    
    
   


}

