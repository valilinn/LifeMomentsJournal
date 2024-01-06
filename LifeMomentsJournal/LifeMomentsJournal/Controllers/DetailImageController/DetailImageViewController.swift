//
//  DetailImageViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 04/01/2024.
//

import UIKit

class DetailImageViewController: UIViewController {
    
    var viewModel: DetailImageViewModel?
    
    private var detailImageView = DetailImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailImageView
        view.backgroundColor = .systemBackground
        setButton()
        setupImage()
    }
    
    private func setButton() {
        detailImageView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupImage() {
        guard let image = viewModel?.image else { return }
        detailImageView.configure(image: image)
    }
}


