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

    let date = BehaviorSubject<String>(value: "")
    let title = BehaviorSubject<String>(value: "")
    let content = BehaviorSubject<String>(value: "")
    let images = BehaviorSubject<[Data]>(value: [])
    let imagesURL = BehaviorSubject<[String]>(value: [])
    var allSelectedImages: [Data] {
        if let allImages = try? images.value() {
            return allImages
        }
        return []
    }
    
    
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
        let currentDate = CurrentDate().date
        date.onNext(currentDate)
    }
    
    func createEntry() {
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
    
    func updateEntry(newEntry: Entry) {
        title.onNext(newEntry.title ?? "")
        content.onNext(newEntry.content ?? "")
        images.onNext(newEntry.imagesData ?? [])
    }
    
    func didSelectImages(_ selectedImages: [Data]) {
            images.onNext(selectedImages)
        }
    
    
    func removeImage(at index: Int) {
        
        if var currentImages = try? images.value() {
            guard index >= 0 && index < currentImages.count else {
                return
            }
            currentImages.remove(at: index)
            images.onNext(currentImages)
        }
    }
    
    
}
