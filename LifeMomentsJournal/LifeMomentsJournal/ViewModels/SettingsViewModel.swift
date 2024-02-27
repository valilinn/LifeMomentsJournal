//
//  SettingsViewModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 02/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsViewModel {
    
    var userPhoto = BehaviorSubject(value: String())
    var userName = BehaviorSubject(value: String())
    var settings = BehaviorSubject(value: [Settings]())
    
    func getUserInfo() {
        guard let userPhoto = AuthenticationService.shared.userPhoto else { return }
        self.userPhoto.onNext(userPhoto)
        guard let userName = AuthenticationService.shared.userName else { return }
        self.userName.onNext(userName)
    }
    
    func getSettings() {
        let support = Settings(icon: "questionmark.circle", title: "Support")
        let aboutDev = Settings(icon: "info.circle", title: "About the Developer")
        let signOut = Settings(icon: "arrow.forward.to.line", title: "Sign Out")
        let deleteAccount = Settings(icon: "trash", title: "Delete Account")
        let settingsArray = [support, aboutDev, signOut, deleteAccount]
        settings.onNext(settingsArray)
    }
    
    
}
