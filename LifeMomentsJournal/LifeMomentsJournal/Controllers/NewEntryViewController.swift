//
//  NewEntryViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit

class NewEntryViewController: UIViewController {
    
    private let newEntryView = NewEntryView()
//    private let newEntryImagesView = NewEntryCollectionView()
    private let imageView = UIImageView()
    private let entries = Entry.getMockData()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = newEntryView
        newEntryView.imagesCollectionView.collectionView.delegate = self
        newEntryView.imagesCollectionView.collectionView.dataSource = self
        newEntryView.imagesCollectionView.collectionView.collectionViewLayout = createLayout()
        newEntryView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(1), items: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        }
    }

    @objc
    func doneButtonTapped() {
        dismiss(animated: true)
        let vc = TabBarViewController()
        present(vc, animated: true)
    }

    

}

extension NewEntryViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if entries.count <= 10 {
            return entries.count
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentEntry = entries[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesViewCell.reuseID, for: indexPath) as! ImagesViewCell
        
        cell.imageView.image = UIImage(named: currentEntry.image)
        
        return cell
    }
}
