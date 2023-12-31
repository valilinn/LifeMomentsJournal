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
        setBinds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.fetchImages()
        }
    }
    
    private func setBinds() {
        viewModel.imagesURL
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] imageURLs in
                self?.imagesView.collectionView.reloadData()
            })
            .disposed(by: bag)
        
        viewModel.imagesURL
            .bind(to: imagesView.collectionView.rx.items(cellIdentifier: ImagesViewCell.reuseID, cellType: ImagesViewCell.self)) { index, imageURL, cell in
                cell.configure(with: imageURL)
            }
            .disposed(by: bag)
        
        imagesView.collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let images = try? self?.viewModel.imagesURL.value() else { return }
            let selectedImage = images[indexPath.row]
            let detailViewModel = DetailImageViewModel()
            detailViewModel.image = selectedImage
            let vc = DetailImageViewController()
            vc.viewModel = detailViewModel
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }).disposed(by: bag)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacingTopBottom: 0, spacingLeadingTrailing: 0)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(200), item: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }

}

extension ImagesViewController: UICollectionViewDelegate {}
