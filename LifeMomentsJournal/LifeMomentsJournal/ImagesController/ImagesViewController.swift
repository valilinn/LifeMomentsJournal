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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.fetchImages()
        }
    }
    
    private func setBind() {
        
//        viewModel.entries
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] _ in
////                self?.imagesView.collectionView.reloadData()
//            })
//            .disposed(by: bag)
        
        viewModel.imagesURL
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] imageURLs in
                print("Received images")
                self?.imagesView.collectionView.reloadData()
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
