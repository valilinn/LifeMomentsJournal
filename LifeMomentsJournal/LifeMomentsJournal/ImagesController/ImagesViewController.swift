//
//  ImagesViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/12/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ImagesViewController: UIViewController {
    
    private let imagesView = ImagesView()
    private let viewModel = ImagesViewModel()
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = imagesView
        navigationController?.navigationBar.prefersLargeTitles = true
        imagesView.collectionView.collectionViewLayout = createLayout()
        setBind()
        viewModel.fetchImages()
    }
    
    private func setBind() {
        
        viewModel.imagesURL
                .subscribe(onNext: { imageURLs in
                    print("Received images: \(imageURLs)")
                })
                .disposed(by: bag)
        
        viewModel.imagesURL
            .bind(to: imagesView.collectionView.rx.items(cellIdentifier: ImagesViewCell.reuseID, cellType: ImagesViewCell.self)) { index, imageURL, cell in
                cell.configure(with: imageURL)
            }
            .disposed(by: bag)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            //            guard let self = self else { return nil }
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacingTopBottom: 0, spacingLeadingTrailing: 0)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(200), item: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    

}

extension ImagesViewController: UICollectionViewDelegate {}
