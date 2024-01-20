//
//  NewEntryViewModel.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 16/12/2023.
//

import Foundation
import RxSwift
import RxCocoa

class NewEntryViewModel {

    let documentId = BehaviorSubject<String?>(value: nil)
    let date = BehaviorSubject<String>(value: "")
    let title = BehaviorSubject<String>(value: "")
    let content = BehaviorSubject<String>(value: "")
    let images = BehaviorSubject<[Data]>(value: [])
    let imagesURL = BehaviorSubject<[String]>(value: [])
    var allSelectedImages: [Data] = []
    
    private let cameraSelectedSubject = PublishSubject<Void>()
    var cameraSelected: Observable<Void> {
        return cameraSelectedSubject.asObservable()
    }
    
    private let photoLibrarySelectedSubject = PublishSubject<Void>()
    var photoLibrarySelected: Observable<Void> {
        return photoLibrarySelectedSubject.asObservable()
    }
    
    func didSelectCamera() {
        cameraSelectedSubject.onNext(())
    }
    
    func didSelectPhotoLibrary() {
        photoLibrarySelectedSubject.onNext(())
    }
    
    func getCurrentDate() {
        if let date = try? date.value(), !date.isEmpty {
            return
        } else {
            let currentDate = CurrentDate().date
            date.onNext(currentDate)
        }
    }
    
    func createEntry() {
        print("create")
        guard let userId = AuthenticationService.shared.userId else { return }
        guard let date = try? date.value() else { return }
        guard let title = try? title.value() else { return }
        var currentContent: String
        do {
            currentContent = try content.value()
            if currentContent == "Write something..." {
                currentContent = ""
            }
        } catch {
            currentContent = ""
        }
        guard let images = try? images.value() else { return }
        let entry = Entry(userId: userId, date: date, title: title, content: currentContent, imagesData: images)
        FirestoreAndStorageService.shared.saveEntry(entry: entry)
    }
    
    func updateEntry() {
        print("update")
        guard let userId = AuthenticationService.shared.userId else { return }
        guard let documentId = try? documentId.value() else { return }
        guard let date = try? date.value() else { return }
        guard let title = try? title.value() else { return }
        var currentContent: String
        do {
            currentContent = try content.value()
            if currentContent == "Write something..." {
                currentContent = ""
            }
        } catch {
            currentContent = ""
        }
        guard let images = try? images.value() else { return }
        let entry = Entry(userId: userId, documentId: documentId, date: date, title: title, content: currentContent, imagesData: images)
        FirestoreAndStorageService.shared.updateEntry(entry: entry)
    }
    
    func didSelectImages() {
            images.onNext(allSelectedImages)
        }
    
    func uploadImagesToUpdate() {
        guard let imagesURL = try? imagesURL.value() else { return }
        var currentImagesData = [Data]()
        
        let dispatchGroup = DispatchGroup()
        
        for image in imagesURL {
            dispatchGroup.enter()
            if let imageURL = URL(string: image) {
                URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    if let error = error {
                        print("Ошибка при загрузке данных из URL: \(error)")
                        return
                    }
                    if let imageData = data {
                        currentImagesData.append(imageData)
                    }
                }.resume()
            }
            
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.images.onNext(currentImagesData)
            self?.allSelectedImages = currentImagesData
        }
    }
    
    
    func removeImage(at index: Int) {
        
        if var currentImagesData = try? images.value() {
            guard index >= 0 && index < currentImagesData.count else {
                return
            }
            currentImagesData.remove(at: index)
            images.onNext(currentImagesData)
            allSelectedImages = currentImagesData
            
        }
        
//        if var currentImagesURL = try? imagesURL.value() {
//            guard index >= 0 && index < currentImagesURL.count else {
//                return
//            }
//            currentImagesURL.remove(at: index)
//            imagesURL.onNext(currentImagesURL)
//        }
    }
    
    
}
