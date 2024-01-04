//
//  WelcomeViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/01/2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let welcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = welcomeView
        welcomeView.getStartedButton.addTarget(self, action: #selector(openAuth), for: .touchUpInside)
    }
    
    @objc
    private func openAuth() {
       let vc = AuthenticationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

//#Preview {
//    WelcomeViewController()
//}
