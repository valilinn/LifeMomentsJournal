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
        detailEntryView.imagesCollectionView.collectionView.collectionViewLayout = createLayout()
        setBind()
    }
    
    private func setBind() {
        viewModel?.entry
            .subscribe(onNext: { [weak self] entry in
                guard let entry = entry else { return }
                self?.detailEntryView.configureDetailView(entry: entry)
                
                let collectionViewHeight = entry.imagesURL?.isEmpty == true ? 0 : 300
                self?.detailEntryView.collectionViewHeightConstraint?.update(offset: collectionViewHeight)
                
                self?.detailEntryView.imagesCollectionView.collectionView.reloadData()
            })
            .disposed(by: bag)
        
        viewModel?.entry
            .observe(on: MainScheduler.instance)
            .compactMap { $0 } //filter out nil values of Entry
            .flatMap { Observable.just($0.imagesURL ?? [])} //transform Entry to its imageURL array
            .bind(to: detailEntryView.imagesCollectionView.collectionView.rx.items(cellIdentifier: DetailEntryImagesViewCell.reuseID, cellType: DetailEntryImagesViewCell.self)) { index, imageURL, cell in
                DispatchQueue.main.async {
                    cell.configure(with: imageURL)
                }
            }
            .disposed(by: bag)
        
        detailEntryView.imagesCollectionView.collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            print(indexPath.row)
            guard let entry = try? self?.viewModel?.entry.value() else { return }
            guard let selectedImage = entry.imagesURL?[indexPath.row] else { return } 
            print("selected image is \(selectedImage)")
            let detailViewModel = DetailImageViewModel()
            detailViewModel.image = selectedImage
            let vc = DetailImageViewController()
            vc.viewModel = detailViewModel
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }).disposed(by: bag)
        
        
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacingTopBottom: 0, spacingLeadingTrailing: 0)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(1), items: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section

        }
    }
   

}

extension DetailEntryCollectionView: UICollectionViewDelegate {}
