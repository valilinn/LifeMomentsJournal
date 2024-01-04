//
//  JournalViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 28/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

class JournalViewController: UIViewController {
    
    private let journalView = JournalView()
    private let viewModel = EntryListViewModel()
    private var bag = DisposeBag()
    private let signOutButton = UIButton()
    private let signOutButtonTitle = UILabel()
    private let tableViewHeight: CGFloat = 150
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = journalView
        journalView.tableView.delegate = self
        setButton()
        bindTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.fetchEntries()
            self?.viewModel.getQuote()
        }
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
        
        viewModel.quote
            .subscribe(onNext: { [weak self] quote in
                self?.journalView.headerLabel.text = quote
                self?.journalView.headerView.layoutIfNeeded()
            })
            .disposed(by: bag)
        
        journalView.tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let entries = try? self?.viewModel.entries.value() else { return }
            let selectedEntry = entries[indexPath.row]
            let detailViewModel = DetailEntryViewModel()
            detailViewModel.entry.onNext(selectedEntry)
            let vc = DetailEntryViewController()
            vc.viewModel = detailViewModel
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
        
        journalView.tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.viewModel.deleteEntry(index: indexPath.row)
            print("Deleted item - \(indexPath.row)")
        }).disposed(by: bag)
    }
    
}




extension JournalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16) 
        cell.contentView.frame = cell.contentView.frame.inset(by: inset)
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

