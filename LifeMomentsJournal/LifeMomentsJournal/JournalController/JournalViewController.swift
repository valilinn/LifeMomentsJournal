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
//    private var previousOffset: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = journalView
//        journalView.collectionView.collectionViewLayout = createLayout()
        journalView.tableView.delegate = self
//        journalView.collectionView.dataSource = self
//        journalView.collectionView.isEditing = true
//        navigationController?.navigationBar.prefersLargeTitles = true
        setButton()
        bindTableView()
        viewModel.fetchEntries()
        viewModel.getQuote()
        journalView.tableView.tableHeaderView = createHeaderView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.fetchEntries()
        viewModel.getQuote()
        journalView.tableView.tableHeaderView = createHeaderView()
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
    
    private func bindTableView() {
        viewModel.entries
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.journalView.tableView.reloadData()
            })
            .disposed(by: bag)
        
        viewModel.entries
            .observe(on: MainScheduler.instance)
            .bind(to: journalView.tableView.rx.items(cellIdentifier: EntriesListCell.reuseID, cellType: EntriesListCell.self)) { index, entry, cell in
                
                DispatchQueue.main.async {
                    cell.configure(with: entry)
                }
            }
            .disposed(by: bag)
        
        journalView.tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
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
        
        
        journalView.tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.viewModel.deleteEntry(index: indexPath.row)
            print("Deleted item - \(indexPath.row)")
        }).disposed(by: bag)
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "mainColor")
       
        
        let headerLabel = UILabel()
    
        
        headerLabel.textColor = .white
        headerLabel.font = .italicSystemFont(ofSize: 14)
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.numberOfLines = 0
        
        
        viewModel.quote
            .subscribe(onNext: { quote in
                headerLabel.text = quote
            })
            .disposed(by: bag)
        
        headerView.addSubview(headerLabel)
        headerLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 32
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-35)
            
        }
        
        // Устанавливаем высоту заголовка (важно для поддержки Auto Layout)
        headerView.snp.makeConstraints {
            $0.height.equalTo(120)
        }
        
        return headerView
    }
    
//    private func createLayout() -> UICollectionViewCompositionalLayout {
//        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
////            guard let self = self else { return nil }
//                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacingTopBottom: 5, spacingLeadingTrailing: 12)
//            let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.25), item: item, count: 1)
//                let section = NSCollectionLayoutSection(group: group)
//                return section
//        }
//    }
    
//    private func configureUIElements() {
//        view.addSubview(containerView)
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        containerView.backgroundColor = UIColor(named: "mainColor")
//    }
}




extension JournalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 150
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor(named: "mainColor") // Цвет вашего заголовка
//        // Добавьте ваши элементы заголовка (например, название секции) в headerView
//        // Добавьте UILabel для отображения текста заголовка
//        let headerLabel = UILabel()
//        
//        viewModel.quote
//            .subscribe(onNext: {  quote in
//                headerLabel.text = quote
//            })
//            .disposed(by: bag)
//        
////        headerLabel.text = "Header"
//        headerLabel.textColor = .white // Установите желаемый цвет текста
//        headerLabel.font = .italicSystemFont(ofSize: 14)
//        headerLabel.numberOfLines = 0// Установите желаемый шрифт
//        
//        // Добавьте headerLabel в headerView и установите ограничения
//        headerView.addSubview(headerLabel)
//        headerLabel.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(16)
//            $0.centerY.equalToSuperview()
//            $0.trailing.equalToSuperview().offset(-35)
//        }
//        return headerView
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 120 // Высота вашего заголовка
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        // Возвращаете заголовок для секции
//        return "Your Section Title"
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16) 
        cell.contentView.frame = cell.contentView.frame.inset(by: inset)
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//extension JournalViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        
//        // Проверяем направление скролла
//        if offsetY > previousOffset {
//            print(offsetY)
//            // Скролл вниз, прячем заголовок
//            UIView.animate(withDuration: 0.3) {
//                self.journalView.tableView.tableHeaderView?.alpha = 0
//            }
//        } else if offsetY < previousOffset {
//            // Скролл вверх, показываем заголовок
//            UIView.animate(withDuration: 0.3) {
//                self.journalView.tableView.tableHeaderView?.alpha = 1
//            }
//        }
//        
//        previousOffset = offsetY
//    }
//}
