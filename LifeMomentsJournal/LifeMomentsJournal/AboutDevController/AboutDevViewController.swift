//
//  AboutDevViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/01/2024.
//

import UIKit
import SnapKit
import MessageUI

class AboutDevViewController: UIViewController {
    
    private let containerView = UIView()
    private let imageContainerView = UIView()
    private let image = UIImageView()
    private let name = UILabel()
    private let aboutInfo = UILabel()
    private let telegramImage = UIImageView()
    private let telegramButton = UIButton()
    private let emailImage = UIImageView()
    private let emailButton = UIButton()
    private let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fillViews()
        setViews()
        setConstraints()
    }
    
    private func fillViews() {
        containerView.backgroundColor = UIColor(named: "mainColor")
        
        imageContainerView.backgroundColor = .white
        imageContainerView.layer.cornerRadius = 60
        imageContainerView.layer.masksToBounds = true
        
        image.image = UIImage(named: "photoOfDeveloper")
        name.text = "Valentyna Linchuk"
        name.textColor = UIColor.white
        name.font = .systemFont(ofSize: 18, weight: .bold)
        aboutInfo.text = "  The creator of Life Moments Journal app that will allow you to remember the most pleasant and wonderful moments in life. \n\n  If you have any suggestions or interesting ideas on how to improve this app, feel free to write to me."
        aboutInfo.numberOfLines = 0
        aboutInfo.textColor = UIColor.white
        
        telegramImage.image = UIImage(named: "telegram")
        telegramImage.contentMode = .scaleAspectFit
        
        emailImage.image = UIImage(named: "email")
        emailImage.contentMode = .scaleAspectFit
        
        telegramButton.setTitle("Send a message via Telegram", for: .normal)
        telegramButton.setTitleColor(.white, for: .normal)
        telegramButton.tintColor = .black
        
        emailButton.setTitle("Send an email", for: .normal)
        emailButton.setTitleColor(.white, for: .normal)
        emailButton.tintColor = .black
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
    }
    
    private func setViews() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        telegramButton.addTarget(self, action: #selector(openTelegram), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(openEmailApp), for: .touchUpInside)
        
    }
    
    @objc
    private func openTelegram() {
        if let url = URL(string: "https://t.me/valinchuk") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc
    private func openEmailApp() {
        emailApp()
    }
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setConstraints() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(20)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        
        containerView.addSubview(imageContainerView)
        imageContainerView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(80)
            $0.leading.equalTo(containerView.snp.leading).offset(32)
            $0.width.height.equalTo(120)
        }
        
        imageContainerView.addSubview(image)
        image.snp.makeConstraints {
            $0.centerY.equalTo(imageContainerView.snp.centerY)
            $0.centerX.equalTo(imageContainerView.snp.centerX)
            $0.width.height.equalTo(115)
        }
        
        containerView.addSubview(name)
        name.snp.makeConstraints {
            $0.centerY.equalTo(image.snp.centerY)
            $0.leading.equalTo(image.snp.trailing).offset(16)
        }
        
        containerView.addSubview(aboutInfo)
        aboutInfo.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(50)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-32)
        }
        
        containerView.addSubview(telegramImage)
        telegramImage.snp.makeConstraints {
            $0.top.equalTo(aboutInfo.snp.bottom).offset(80)
            $0.leading.equalTo(containerView.snp.leading).offset(32)
            $0.width.height.equalTo(50)
        }
        
        containerView.addSubview(telegramButton)
        telegramButton.snp.makeConstraints {
            $0.centerY.equalTo(telegramImage.snp.centerY)
            $0.leading.equalTo(telegramImage.snp.trailing).offset(16)
        }
        
        containerView.addSubview(emailImage)
        emailImage.snp.makeConstraints {
            $0.top.equalTo(telegramImage.snp.bottom).offset(16)
            $0.leading.equalTo(containerView.snp.leading).offset(32)
            $0.width.height.equalTo(50)
        }
        containerView.addSubview(emailButton)
        emailButton.snp.makeConstraints {
            $0.centerY.equalTo(emailImage.snp.centerY)
            $0.leading.equalTo(emailImage.snp.trailing).offset(16)
        }
        
    }
    
    
    
}

extension AboutDevViewController: MFMailComposeViewControllerDelegate {
    func emailApp() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["valentinalinchuk@gmail.com"])
            mail.setSubject("Subject")
            mail.setMessageBody("<p>Write something...</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Error - can't send email to the developer")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        //... handle email screen actions
        controller.dismiss(animated: true)
    }
}

//#Preview {
//    AboutDevViewController()
//}
