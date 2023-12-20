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
    var entries = BehaviorSubject(value: [Entry]())
    var entriesArray = [Entry]()
    
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
    
    func createEntry(entry: Entry) {
        entriesArray.insert(entry, at: 0)
        self.entries.onNext(entriesArray)
//        print("My notes - \(try? entries.value())")
    }
   
}
