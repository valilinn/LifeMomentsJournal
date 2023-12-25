//
//  FirestoreAndStorageService.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 21/12/2023.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseStorage

class FirestoreAndStorageService {
    
    static let shared = FirestoreAndStorageService()
    
    private let database = Firestore.firestore()
    
    func saveEntryToFirestore(entry: Entry, images: [UIImage]) {
        let entriesRef = database.collection("entries")
        
        let newDocumentRef = entriesRef.document() // Create a reference to a new document
        let documentId = newDocumentRef.documentID  // Get the document ID
        print("document ID Firestore is \(documentId)")
        
        
        newDocumentRef.setData([
            "id": entry.id,
            "userId": entry.userId,
            "date": entry.date,
            "title": entry.title ?? "",
            "content": entry.content ?? ""
        ]) { [weak self] error in
            if let error = error {
                print("Error addimg document \(error)")
            } else {
                print("Document added successfully")
            }
            
            print("document ID Firestore is \(documentId)")
            
            for (index, image) in images.enumerated() {
                self?.uploadImages(index: index, image: image, documentId: documentId ?? "")
            }
        }
    }
    
    func uploadImages(index: Int, image: UIImage, documentId: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("images/\(documentId)")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let imageRef = storageRef.child("image_\(index).jpg")
            
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard let _ = metadata else {
                    print("Error uploading image: \(error.debugDescription)")
                    return
                }
                print("Image uploaded successfully")
                print("document ID Storage is \(documentId)")
            }
        }
    }
}
