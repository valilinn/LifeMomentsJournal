//
//  WelcomeViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/01/2024.
//

import UIKit
import SnapKit
import Lottie

class WelcomeViewController: UIViewController {
    
    private let containerView = UIView()
    private var animationView: LottieAnimationView?
    private let welcomeLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let getStartedButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottie()
        fillViews()
        setViews()
        setConstraints()
    }
    
    private func setupLottie() {
        animationView = .init(name: "animationIcon")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
//        view.addSubview(animationView!)
        animationView!.play()
    }
    
    private func fillViews() {
        
        welcomeLabel.text = "Welcome to\nLife Moments Journal!"
        descriptionLabel.text = "Your diary that will store\nyour memories and thoughts"
        getStartedButton.setTitle("Get Started", for: .normal)
    }
    
    private func setViews() {
        containerView.backgroundColor = UIColor(named: "mainColor")
        welcomeLabel.font = .systemFont(ofSize: 26, weight: .bold)
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        
        welcomeLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = .center
        
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        getStartedButton.backgroundColor = UIColor(named: "buttonColor")
        getStartedButton.layer.cornerRadius = 10.0
        getStartedButton.frame = CGRect(x: 50, y: 50, width: 300, height: 40)
        
        getStartedButton.addTarget(self, action: #selector(openAuth), for: .touchUpInside)
    }
  
    private func setConstraints() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(animationView!)
        animationView!.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(150)
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.height.equalTo(200)
        }
        
        containerView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(animationView!.snp.bottom).offset(32)
            $0.centerX.equalTo(containerView.snp.centerX)
        }
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(32)
            $0.centerX.equalTo(containerView.snp.centerX)
        }
        
        containerView.addSubview(getStartedButton)
        getStartedButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(60)
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.width.equalTo(190)
            $0.height.equalTo(50)
        }
    }
    
    @objc
    private func openAuth() {
       let vc = AuthenticationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

//#Preview {
//    WelcomeViewController()
//}
