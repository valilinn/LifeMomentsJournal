//
//  AuthenticationModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 26/11/2023.
//

import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthenticationService {
    
    static let shared = AuthenticationService()
    private init() {}
   
    var state: SignInState = .signedOut
    var userId: String?
    var userName: String?
    var userPhoto: String?
    var stateKey = "authentication"
    
    enum SignInState: String {
        case signedIn = "signedIn"
        case signedOut = "signedOut"
    }
    
    
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(state.rawValue, forKey: stateKey)
        defaults.set(userId, forKey: "userId")
        defaults.set(userName, forKey: "userName")
        defaults.set(userPhoto, forKey: "userPhoto")
    }
    
    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let userIdValue = defaults.string(forKey: "userId") {
            userId = userIdValue
        }
        if let userNameValue = defaults.string(forKey: "userName") {
            userName = userNameValue
        }
        if let userPhotoValue = defaults.string(forKey: "userPhoto") {
            userPhoto = userPhotoValue
        }
    }
    
    func signIn(vc: UIViewController, completion: @escaping ((Bool) -> Void)) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] result, error in
          guard error == nil else { return }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString else { return }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                if let error = error {
                    completion(false)
                    print(error.localizedDescription)
                } else {
                    let firebaseUser = result?.user
                    let userID = firebaseUser?.uid
                    self?.userId = userID
                    let userName = firebaseUser?.displayName
                    self?.userName = userName
                    let userPhoto = firebaseUser?.photoURL
                    self?.userPhoto = userPhoto?.absoluteString
                    self?.saveToUserDefaults()
                    print("My name is -\(firebaseUser?.displayName)")
                    print("User\(firebaseUser?.uid) signed in with email \(firebaseUser?.email ?? "unknown")")
                    completion(true)
                }
                print("Sign in successful!")
                
              // At this point, our user is signed in
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            state = .signedOut
            saveToUserDefaults()
            print("log out")
        } catch {
            print(error.localizedDescription)
        }
    }
}
