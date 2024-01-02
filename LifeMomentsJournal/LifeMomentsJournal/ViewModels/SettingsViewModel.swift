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
    
//    let settings: BehaviorSubject<[String]> = BehaviorSubject(value: ["Support", "About the developer", "Log out"])
    var userPhoto = BehaviorSubject(value: String())
    var userName = BehaviorSubject(value: String())
    var settings = BehaviorSubject(value: [Settings]())
    
    func getUserInfo() {
        guard let userPhoto = AuthenticationService.shared.userPhoto else { return }
        self.userPhoto.onNext(userPhoto)
        guard let userName = AuthenticationService.shared.userName else { return }
        self.userName.onNext(userName)
        
        //to delete
        let defaults = UserDefaults.standard
        print(defaults.string(forKey: "userName"))
        print(defaults.string(forKey: "userPhoto"))
    }
    
    func getSettings() {
        let support = Settings(icon: "questionmark.circle", title: "Support")
        let aboutDev = Settings(icon: "info.circle", title: "About the developer")
        let signOut = Settings(icon: "arrow.forward.to.line", title: "Sign Out")
        let settingsArray = [support, aboutDev, signOut]
        settings.onNext(settingsArray)
    }
    
    
//    func getSettings() {
//        let settings = Settings()
//        self.settings.onNext(settings)
//    }
//    let journalTitle = BehaviorSubject<String>(value: "")
    
//    func updateSettings(title: String?) {
//        guard let title = title else {
//            self.journalTitle.onNext(settings.journalTitle)
//            return
//        }
//        self.journalTitle.onNext(title)
//    }
    
    
    
    
}
