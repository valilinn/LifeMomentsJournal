//
//  DetailEntryViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 29/12/2023.
//

import UIKit
import RxSwift
import RxCocoa

class DetailEntryViewController: UIViewController {
    
    private let detailEntryView = DetailEntryView()
    var viewModel: DetailEntryViewModel?
    private var bag = DisposeBag()
//    var entryIndex: Int?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailEntryView
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.titleView = nil
        title = nil
        detailEntryView.imagesCollectionView.collectionView.collectionViewLayout = createLayout()
        setBind()
    }
    
    private func setBind() {
        viewModel?.entry
            .subscribe(onNext: { [weak self] entry in
                guard let entry = entry else { return }
                self?.detailEntryView.configureDetailView(entry: entry)
                self?.detailEntryView.imagesCollectionView.collectionView.reloadData()
            })
            .disposed(by: bag)
        
//        viewModel?.entry
//            .observe(on: MainScheduler.instance)
//            .bind(to: detailEntryView.imagesCollectionView.collectionView.rx.item(cellIdentifier: DetailEntryImagesViewCell.reuseID, cellType: DetailEntryImagesViewCell.self)) { index, entry, cell in
//                let imageURL = entry?.imagesURL?[index]
//
//                DispatchQueue.main.async {
//                    cell.configure(with: imageURL)
//                }
//            }
//            .disposed(by: bag)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacingTopBottom: 1, spacingLeadingTrailing: 1)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(1), items: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section

        }
    }
   

}

extension DetailEntryCollectionView: UICollectionViewDelegate {}
