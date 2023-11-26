//
//  AuthentificationModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 26/11/2023.
//

import Foundation
import GoogleSignIn

class AuthenticationModel {
    
    var state: SingInState = .signedOut
    
    enum SingInState {
        case signedIn
        case signedOut
    }
}
