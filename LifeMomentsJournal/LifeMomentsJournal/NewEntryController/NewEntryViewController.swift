//
//  NewEntryViewController.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 03/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI
import MobileCoreServices

class NewEntryViewController: UIViewController, UICollectionViewDelegate {
    
    private let newEntryView = NewEntryView()
    private var viewModel = NewEntryViewModel()
    private let bag = DisposeBag()
    
    private let newEntryImagesView = NewEntryCollectionView()
    private let imageView = UIImageView()
    var allSelectedImages = [Data]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = newEntryView
        title = "New Entry"
//        newEntryView.imagesCollectionView.collectionView.delegate = self
//        newEntryView.imagesCollectionView.collectionView.dataSource = self
        newEntryView.imagesCollectionView.collectionView.collectionViewLayout = createLayout()
        viewModel.getCurrentDate()
        setButtons()
        setBind()
        
    }
    
    private func setBind() {
        viewModel.cameraSelected.subscribe(onNext: { [weak self] in
            self?.checkCameraPermissionAndShowPicker()
        })
        .disposed(by: bag)
        
        viewModel.photoLibrarySelected.subscribe(onNext: { [weak self] in
            self?.checkPhotoLibraryPermissionAndShowPicker()
        })
        .disposed(by: bag)
        
        viewModel.date.bind(to: newEntryView.dateLabel.rx.text).disposed(by: bag)
        
        newEntryView.titleView.rx.text.orEmpty
            .bind(to: viewModel.title)
            .disposed(by: bag)
        
        newEntryView.contentView.rx.text.orEmpty
            .bind(to: viewModel.content)
            .disposed(by: bag)
        
        //??
//        newEntryView.addImagesButton.rx.tap
//            .subscribe(onNext: { [weak self] _ in
//                self?.showPickingAlert()
//            })
//            .disposed(by: bag)
        
        viewModel.images
            .observe(on: MainScheduler.instance)
            .bind(to: newEntryView.imagesCollectionView.collectionView.rx.items(cellIdentifier: NewEntryImagesViewCell.reuseID, cellType: NewEntryImagesViewCell.self)) { index, imageData, cell in
                if let image = UIImage(data: imageData) {
                    cell.imageView.image = image
                }
            }
            .disposed(by: bag)

        
    }
    
    private func checkCameraPermissionAndShowPicker() {
        Task {
            if await PhotosManager.hasCameraPermission() {
                showCameraPicker()
            }
        }
    }
    
    private func checkPhotoLibraryPermissionAndShowPicker() {
        Task {
            if await PhotosManager.hasPhotoLibraryPermission() {
                showPhotoLibraryPicker()
            } else {
                showSettingsAlert()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newEntryView.contentView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 1)
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.4), height: .fractionalHeight(1), items: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        }
    }
    
    
    private func setButtons() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = closeButton
        
        newEntryView.saveEntryButton.addTarget(self, action: #selector(saveEntryButtonTapped), for: .touchUpInside)
        
        newEntryView.addImagesButton.addTarget(self, action: #selector(showPickingAlertButtonTapped), for: .touchUpInside)
    }
    

    @objc
    func closeButtonTapped() {
        dismiss(animated: true)
        if let tabBarController = self.presentingViewController as? TabBarViewController {
            tabBarController.selectedIndex = 0
        }
    }
    
    @objc 
    private func showPickingAlertButtonTapped() {
        showPickingAlert()
    }
    
    
    @objc
    private func saveEntryButtonTapped() {
//        let entry = Entry(userId: viewModel.userId , date: newEntryView.dateLabel.text ?? "", title: newEntryView.titleView.text ?? "", content: newEntryView.contentView.text ?? "", images: viewModel.images.value)
        viewModel.createEntry()
        dismiss(animated: true)
        if let tabBarController = self.presentingViewController as? TabBarViewController {
            tabBarController.selectedIndex = 0
        }
    }
    
    private func showPickingAlert() {
        let alert = UIAlertController(title: "Add photo", message: "Choose app for adding photo", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.viewModel.didSelectCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.viewModel.didSelectPhotoLibrary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    private func showSettingsAlert() {
        let alert = UIAlertController(title: "Open Settings", message: "You don't have access to your photo library, want to open settings?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            PhotosManager.openAppPrivacySettings()
        }
       
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    private func showCameraPicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .camera
        present(pickerController, animated: true)
    }
    
    private func showPhotoLibraryPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 50
        
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
    
    
}

//extension NewEntryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        if entries.count <= 10 {
////            return entries.count
////        } else {
////            return 10
////        }
//        return try! viewModel.images.value().count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let currentEntry = entries[indexPath.item]
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewEntryImagesViewCell.reuseID, for: indexPath) as! NewEntryImagesViewCell
//        
//        //        cell.imageView.image = UIImage(named: currentEntry.image)
//        let imageData = try! viewModel.images.value()[indexPath.item]
//        let image = UIImage(data: imageData)
//        
//        cell.imageView.image = image
//        
//        return cell
//    }
//}

extension NewEntryViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let image = info[.originalImage] as? UIImage else {
//            return
//        }
//        picker.dismiss(animated: true)
//        
//        // Обработка выбора изображения
//        // Вызов метода в ViewModel для сохранения изображения
////        viewModel.saveImage(image)
////        images.append(image)
//    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let dispatchGroup = DispatchGroup()
        
        for result in results {
            dispatchGroup.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                defer {
                    dispatchGroup.leave()
                }
                if let image = object as? UIImage, let imageData = image.jpegData(compressionQuality: 0.5) {
                    self?.allSelectedImages.append(imageData)
                } else {
                    print("something is wrong with data")
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            // when all images will loaded
            self.viewModel.didSelectImages(self.allSelectedImages)
        }
    }
}


//#Preview {
//    NewEntryViewController()
//}
