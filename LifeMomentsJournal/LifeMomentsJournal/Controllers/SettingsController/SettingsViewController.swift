//
//  SettingsViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import MessageUI

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    private let viewModel = SettingsViewModel()
    private let tableViewHeight: CGFloat = 60
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        settingsView.settingsTableView.tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.getSettings()
        viewModel.getUserInfo()
        setBinds()
    }
    
    private func setBinds() {
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
                self?.openEmail()
            case 1:
                let vc = AboutDevViewController()
                vc.modalPresentationStyle = .pageSheet
                self?.present(vc, animated: true)
            case 2:
                AuthenticationService.shared.signOut()
                let vc = WelcomeViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
                print("User sign out")
            default:
                return
            }
        }).disposed(by: bag)
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func openEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["test.lmj.app@gmail.com"])
            mail.setSubject("Subject")
            mail.setMessageBody("<p>Write something...</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Can't open email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
}
