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
    private let viewModel: NewEntryViewModel
    private var bag = DisposeBag()
//    private let entries = Entry.getMockData()
    private let containerView = UIView()
    private let signOutButton = UIButton()
    private let signOutButtonTitle = UILabel()
    
    init(viewModel: NewEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = journalView
        journalView.collectionView.collectionViewLayout = createLayout()
        navigationController?.navigationBar.prefersLargeTitles = true
        setButton()
        setBind()
    }
    
    private func setButton() {
        let addEntryButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addEntryButtonTapped))
        addEntryButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = addEntryButton
    }
    
    @objc
    func addEntryButtonTapped() {
        let vc = UINavigationController(rootViewController: NewEntryViewController(viewModel: viewModel))
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func setBind() {
        journalView.collectionView.rx.setDelegate(self).disposed(by: bag)
        viewModel.entries.bind(to: journalView.collectionView.rx.items(cellIdentifier: EntriesListCell.reuseID, cellType: EntriesListCell.self)) { (row, item, cell) in
            print("OK")
            DispatchQueue.main.async {
                cell.configure(with: item)
            }
        }.disposed(by: bag)
        
        
    }
   
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.4), spacing: 3)
            let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.3), item: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                return section
        }
    }
    
    private func configureUIElements() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = UIColor(named: "mainColor")
        
        
    }
    
    

}




extension JournalViewController: UICollectionViewDelegate {}

//extension JournalViewController : UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        entries.count
//    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let currentEntry = entries[indexPath.item]
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EntriesListCell.reuseID, for: indexPath) as! EntriesListCell
//        
//        cell.dateLabel.text = "\(currentEntry.date)"
//        cell.titleLabel.text = "\(currentEntry.title)"
//        cell.contentLabel.text = "\(currentEntry.content)"
//        cell.entryImageView.image = UIImage(named: currentEntry.image)
//        
//        return cell
//    }
    
    
//}
