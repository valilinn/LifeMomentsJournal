//
//  CreateEntryViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit

class CreateEntryViewController: UIViewController {
    
    private let createEntryView = CreateEntryView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = createEntryView
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.tabBarController?.tabBar.barTintColor = UIColor(named: "mainColor")
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        let tabVC = TabBarViewController()
        tabVC.modalTransitionStyle = .crossDissolve
        tabVC.modalPresentationStyle = .fullScreen
        self.present(tabVC, animated: true)
       
    }

    

}


