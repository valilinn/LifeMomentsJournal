//
//  NewEntryViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit

class NewEntryViewController: UIViewController {
    
    private let newEntryView = NewEntryView()
    private let newEntryImagesView = NewEntryCollectionView()
    private let imageView = UIImageView()
    private let entries = Entry.getMockData()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = newEntryView
        newEntryImagesView.collectionView.delegate = self
        newEntryImagesView.collectionView.dataSource = self
        newEntryImagesView.collectionView.collectionViewLayout = createLayout()
        
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            
            
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.4), spacing: 1)
            let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.5), item: item, count: 3)
            let section = NSCollectionLayoutSection(group: group)
            //                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            return section
            
        }
    }

    

    

}

extension NewEntryViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if entries.count >= 10 {
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
