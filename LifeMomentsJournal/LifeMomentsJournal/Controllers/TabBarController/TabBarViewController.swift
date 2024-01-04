//
//  TabBarViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarView()
        selectedIndex = 0
    }
    

    private func setupTabs() {
        let journal = createNav(with: "Journal", and: UIImage(systemName: "book"), mainTitle: "Life Moments Journal", selectedImage: UIImage(systemName: "book.fill"), vc: JournalViewController())
        let photos = createNav(with: "Photos", and: UIImage(systemName: "photo.on.rectangle"), mainTitle: "My Photos", selectedImage: UIImage(systemName: "photo.fill.on.rectangle.fill"), vc: ImagesViewController())
        let settings = createNav(with: "Settings", and: UIImage(systemName: "gearshape"), mainTitle: "Settings", selectedImage: UIImage(systemName: "gearshape.fill"), vc: SettingsViewController())
       
        self.setViewControllers([journal, photos, settings], animated: true)
        
    }

    
    private func setupTabBarView() {
        
        self.tabBar.barTintColor = UIColor(named: "mainColor")
        self.tabBar.tintColor = .white
        let textChangeColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textChangeColor
        navigationController?.navigationBar.largeTitleTextAttributes = textChangeColor
        
        if #available(iOS 15, *) {
            // MARK: Navigation bar appearance
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = UIColor(named: "mainColor")
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        self.tabBar.unselectedItemTintColor = UIColor.white
    }
    
    private func createNav(with title: String?, and image: UIImage?, mainTitle: String?, selectedImage: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.viewControllers.first?.navigationItem.title = mainTitle
        nav.tabBarItem.title = title 
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = selectedImage
        
        return nav
    }

}

