//
//  AuthenticationModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 26/11/2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthenticationModel {
    
   
    var state: SignInState = .signedOut
    var stateKey = "authentication"
    
    enum SignInState: String {
        case signedIn = "signedIn"
        case signedOut = "signedOut"
    }
    
    
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(state.rawValue, forKey: stateKey)
    }
    
    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let stateRawValue = defaults.string(forKey: stateKey),
           let stateType = SignInState(rawValue: stateRawValue) {
            state = stateType
        }
    }


    
}
