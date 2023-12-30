//
//  JournalViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 28/11/2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import RxSwift
import RxCocoa

class JournalViewController: UIViewController {
    
    private let journalView = JournalView()
    private let viewModel = EntryListViewModel()
    private var bag = DisposeBag()
//    private let containerView = UIView()
    private let signOutButton = UIButton()
    private let signOutButtonTitle = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = journalView
        journalView.collectionView.collectionViewLayout = createLayout()
//        journalView.collectionView.isEditing = true
        navigationController?.navigationBar.prefersLargeTitles = true
        setButton()
        setBind()
        viewModel.fetchEntries()
    }
    
    private func setButton() {
        let addEntryButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addEntryButtonTapped))
        addEntryButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = addEntryButton
    }
    
    @objc
    func addEntryButtonTapped() {
        let vc = UINavigationController(rootViewController: NewEntryViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func setBind() {
        viewModel.entries
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.journalView.collectionView.reloadData()
            })
            .disposed(by: bag)
        
        viewModel.entries
            .observe(on: MainScheduler.instance)
            .bind(to: journalView.collectionView.rx.items(cellIdentifier: EntriesListCell.reuseID, cellType: EntriesListCell.self)) { index, entry, cell in
                
                DispatchQueue.main.async {
                    cell.configure(with: entry)
                }
            }
            .disposed(by: bag)
        
        journalView.collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            print(indexPath.row)
            guard var entries = try? self?.viewModel.entries.value() else { return }
            let selectedEntry = entries[indexPath.row]
            print("selected entry is \(selectedEntry)")
            let detailViewModel = DetailEntryViewModel()
            detailViewModel.entry.onNext(selectedEntry)
            let vc = DetailEntryViewController()
            vc.viewModel = detailViewModel
//            vc.entryIndex = indexPath.row
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
//        journalView.collectionView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
//            guard let self = self else { return }
//            self.viewModel.deleteEntry(index: indexPath.row)
//            print("Deleted item - \(indexPath.row)")
//        }).disposed(by: bag)
    }
    
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
//            guard let self = self else { return nil }
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacingTopBottom: 5, spacingLeadingTrailing: 12)
            let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.25), item: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                return section
        }
    }
    
//    private func configureUIElements() {
//        view.addSubview(containerView)
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        containerView.backgroundColor = UIColor(named: "mainColor")
//    }
}




extension JournalViewController: UICollectionViewDelegate {}

