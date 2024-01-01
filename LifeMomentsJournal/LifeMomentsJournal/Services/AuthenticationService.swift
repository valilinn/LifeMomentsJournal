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
    var stateKey = "authentication"
    
    enum SignInState: String {
        case signedIn = "signedIn"
        case signedOut = "signedOut"
    }
    
    
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(state.rawValue, forKey: stateKey)
        defaults.set(userId, forKey: "userId")
    }
    
    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
//        if let stateRawValue = defaults.string(forKey: stateKey),
//           let stateType = SignInState(rawValue: stateRawValue) {
//            state = stateType
//        }
        if let userIdValue = defaults.string(forKey: "userId") {
            userId = userIdValue
        }
    }
    
    func signIn(vc: UIViewController, completion: @escaping ((Bool) -> Void)) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] result, error in
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
                    completion(false)
                    print(error.localizedDescription)
                } else {
                    let firebaseUser = result?.user
                    let userID = firebaseUser?.uid //my id
                    self?.userId = userID //my id
                    self?.saveToUserDefaults()
                    print("My name is -\(firebaseUser?.displayName)")
                    print("User\(firebaseUser?.uid) signed in with email \(firebaseUser?.email ?? "unknown")")
                    completion(true)

                    
                    
                }
                print("Sign in successful!")
                
              // At this point, our user is signed in
            }
            
            // ...
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
