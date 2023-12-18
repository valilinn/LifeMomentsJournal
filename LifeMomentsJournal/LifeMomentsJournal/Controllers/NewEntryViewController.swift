//
//  NewEntryViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit
import RxSwift

class NewEntryViewController: UIViewController {
    
    private let newEntryView = NewEntryView()
    private let viewModel: JournalViewModel
    private let newEntryImagesView = NewEntryCollectionView()
    private let imageView = UIImageView()
//    private let entries = Entry.getMockData()
    
    init(viewModel: JournalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = newEntryView
        title = "New Entry"
        newEntryView.imagesCollectionView.collectionView.delegate = self
        newEntryView.imagesCollectionView.collectionView.dataSource = self
        newEntryView.imagesCollectionView.collectionView.collectionViewLayout = createLayout()
        //        newEntryView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        setButtons()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newEntryView.contentView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    private func setButtons() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = closeButton
        
        newEntryView.saveEntryButton.addTarget(self, action: #selector(saveEntryButtonTapped), for: .touchUpInside)
    }
    
    
    

    @objc
    func closeButtonTapped() {
        dismiss(animated: true)
        if let tabBarController = self.presentingViewController as? TabBarViewController {
            tabBarController.selectedIndex = 0
        }
        
    }
    
    
    @objc
    private func saveEntryButtonTapped() {
        let entry = Entry(date: newEntryView.dateLabel.text ?? "", title: newEntryView.titleView.text ?? "", content: newEntryView.contentView.text ?? "", images: ["morskieOko"])
        viewModel.createEntry(entry: entry)
        dismiss(animated: true)
        if let tabBarController = self.presentingViewController as? TabBarViewController {
            tabBarController.selectedIndex = 0
            print("Button tapped")
//            if let journalViewController = tabBarController.viewControllers?.first as? JournalViewController {
//                journalViewController.viewModel.entries.onNext(journalViewController.viewModel.entriesArray)
//            } // обновить collection?
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 1)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.4), height: .fractionalHeight(1), items: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        }
    }
    

}

extension NewEntryViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if entries.count <= 10 {
//            return entries.count
//        } else {
//            return 10
//        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let currentEntry = entries[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewEntryImagesViewCell.reuseID, for: indexPath) as! NewEntryImagesViewCell
        
//        cell.imageView.image = UIImage(named: currentEntry.image)
        
        
        return cell
    }
}

//#Preview {
//    NewEntryViewController()
//}
