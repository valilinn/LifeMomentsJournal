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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailEntryView
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
        detailEntryView.imagesCollectionView.collectionView.collectionViewLayout = createLayout()
        setBinds()
        setButton()
    }
    
    private func setBinds() {
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
            guard let entry = try? self?.viewModel?.entry.value() else { return }
            guard let selectedImage = entry.imagesURL?[indexPath.row] else { return } 
            let detailViewModel = DetailImageViewModel()
            detailViewModel.image = selectedImage
            let vc = DetailImageViewController()
            vc.viewModel = detailViewModel
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }).disposed(by: bag)
        
        
    }
    
    private func setButton() {
        detailEntryView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func editButtonTapped() {
        guard let entry = try? viewModel?.entry.value() else { return }
        
        let newEntryViewModel = NewEntryViewModel()
        let vc = NewEntryViewController()
        vc.updateEntry(entry: entry)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacingTopBottom: 0, spacingLeadingTrailing: 0)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(1), items: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section

        }
    }
}

extension DetailEntryCollectionView: UICollectionViewDelegate {}
