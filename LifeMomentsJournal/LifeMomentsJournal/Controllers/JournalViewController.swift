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

class JournalViewController: UIViewController, UICollectionViewDelegate {
    
    private let journalView = JournalView()
    private let entries = Entry.getMockData()
    
    private let authModel = AuthenticationService()
    
    private let containerView = UIView()
    private let signOutButton = UIButton()
    private let signOutButtonTitle = UILabel()
    
    let disposeBag = DisposeBag()
    let testItems = Observable.just(["One", "Two", "Three", "Four"])
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = journalView
//        journalView.collectionView.delegate = self
//        journalView.collectionView.dataSource = self
        journalView.collectionView.collectionViewLayout = createLayout()
        navigationController?.navigationBar.prefersLargeTitles = true
//        configureUIElements()
        setBind()
    }
    
    private func setBind() {
        testItems.bind(to: journalView.collectionView
            .rx
            .items(cellIdentifier: EntriesListCell.reuseID, cellType: EntriesListCell.self)) {
                (_, element, cell) in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
    }
   
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
//            let section = self.sections.sectionsList[sectionIndex]
//            switch section {
//            case .mainSection:
//                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.6), height: .fractionalHeight(1), spacing: 0)
//                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.4), item: item, count: 1)
//                let section = NSCollectionLayoutSection(group: group)
//                return section
//            case .hourlySection:
//                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.7), height: .fractionalHeight(1), spacing: 0)
//                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(90), height: .absolute(130), item: item, count: 1)
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuous
//                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
//                return section
//            case .dailySection:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.4), spacing: 1)
            let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.2), item: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
//                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                return section
//            case .detailSection:
//                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
//                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(200), item: item, count: 2)
//                let section = NSCollectionLayoutSection(group: group)
//                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
//                return section
//            }
        }
    }
    
    private func configureUIElements() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = UIColor(named: "mainColor")
        configSignOutButton()
        
        
        
    }
    
    private func configSignOutButton() {
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.tintColor = .white
        signOutButton.backgroundColor = .red

        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)

        containerView.addSubview(signOutButton)

        signOutButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
        }
    }
    
    @objc
    private func signOut() {
//        GIDSignIn.sharedInstance.signOut()
//        
//        do {
//            try Auth.auth().signOut()
//            authModel.state = .signedOut
//            authModel.saveToUserDefaults()
//            print("log out")
//        } catch {
//            print(error.localizedDescription)
//        }
    }


}

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
