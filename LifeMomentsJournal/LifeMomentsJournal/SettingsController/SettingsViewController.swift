//
//  SettingsViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/12/2023.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    private let viewModel = SettingsViewModel()
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        settingsView.settingsTableView.tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.getSettings()
        viewModel.getUserInfo()
        setBind()
    }
    
    private func setBind() {
        viewModel.userPhoto
            .subscribe(onNext: { [weak self] userPhoto in
                DispatchQueue.main.async {
                    self?.settingsView.configureUserPhoto(photoURL: userPhoto)
                }
            })
            .disposed(by: bag)
        
        viewModel.userName
            .subscribe(onNext: { [weak self] userName in
                DispatchQueue.main.async {
                    self?.settingsView.configureUserName(name: userName)
                }
            })
            .disposed(by: bag)
        
        viewModel.settings
            .observe(on: MainScheduler.instance)
            .bind(to: settingsView.settingsTableView.tableView.rx.items(cellIdentifier: SettingsViewCell.reuseID, cellType: SettingsViewCell.self)) { index, item, cell in
                
                DispatchQueue.main.async {
                    cell.configure(with: item)
                }
            }
            .disposed(by: bag)
        
        settingsView.settingsTableView.tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            switch indexPath.row {
            case 0:
                print("Row - 0")
            case 1:
                print("Row - 1")
            case 2:
                AuthenticationService.shared.signOut()
                let vc = AuthenticationViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
                print("User sign out")
            default:
                return
            }
//            print(indexPath.row)
//            guard var entries = try? self?.viewModel.entries.value() else { return }
//            let selectedEntry = entries[indexPath.row]
//            print("selected entry is \(selectedEntry)")
//            let detailViewModel = DetailEntryViewModel()
//            detailViewModel.entry.onNext(selectedEntry)
//            let vc = DetailEntryViewController()
//            vc.viewModel = detailViewModel
//            vc.hidesBottomBarWhenPushed = true
//            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
    }
    

}

extension SettingsViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // Возвращаем количество ячеек в таблице
//        return 4
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let inset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
//        cell.contentView.frame = cell.contentView.frame.inset(by: inset)
//        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
