//
//  TabBarViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
//    let viewModel = NewEntryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
        setupTabs()
        setupTabBarView()
        selectedIndex = 0
    }
    

    private func setupTabs() {
        let journal = createNav(with: "Journal", and: UIImage(systemName: "book"), mainTitle: "Life Moments Journal", selectedImage: UIImage(systemName: "book.fill"), vc: JournalViewController())
       
        self.setViewControllers([journal], animated: true)
        
    }

    
    private func setupTabBarView() {
        
        self.tabBar.barTintColor = UIColor(named: "mainColor")//background
        self.tabBar.tintColor = .white //text and icon
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
        self.tabBar.unselectedItemTintColor = UIColor.white //unselected text and icon
    }
    
    private func createNav(with title: String?, and image: UIImage?, mainTitle: String?, selectedImage: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.viewControllers.first?.navigationItem.title = mainTitle //main name
        nav.tabBarItem.title = title //tab name
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = selectedImage
        
        return nav
    }

}

//extension TabBarViewController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if self.selectedIndex == 1 {
//            let vc = UINavigationController(rootViewController: NewEntryViewController(viewModel: viewModel)) 
//            vc.modalPresentationStyle = .fullScreen
//            
//            present(vc, animated: true)
//        }
//    }
//    
//    
//}
