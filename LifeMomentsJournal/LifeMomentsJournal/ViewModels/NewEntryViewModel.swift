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
//    let saveEntryTapped = PublishSubject<Void>()
    
    
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
        let entry = Entry(userId: userId, date: try! date.value(), title: try! title.value(), content: try! content.value(), imagesData: try! images.value() )
        FirestoreAndStorageService.shared.saveEntry(entry: entry)
    }
    
    func updateEntry(newEntry: Entry) {
//        let updatedEntry = Entry(userId: newEntry.userId, date: newEntry.date, title: newEntry.title, content: newEntry.content, images: newEntry.images)
//        entry.onNext(updatedEntry)
//        date.onNext(newEntry.date)
        title.onNext(newEntry.title ?? "")
        content.onNext(newEntry.content ?? "")
        images.onNext(newEntry.imagesData ?? [])
    }
    
    func didSelectImages(_ selectedImages: [Data]) {
            images.onNext(selectedImages)
        }
    
    
    
}
