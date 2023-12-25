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
import FirebaseCore

class FirestoreAndStorageService {
    
    static let shared = FirestoreAndStorageService()
    
    private let database = Firestore.firestore()
    
    func saveEntry(entry: Entry) {
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
            
            if let imagesEnumerated = entry.images?.enumerated() {
                for (index, image) in imagesEnumerated {
                    self?.uploadImages(index: index, image: image, documentId: documentId)
                }
            }
        }
    }
    
    private func uploadImages(index: Int, image: Data, documentId: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("images/\(documentId)")
        let imageRef = storageRef.child("image_\(index).jpg")
        
        imageRef.putData(image, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                print("Error uploading image: \(error.debugDescription)")
                return
            }
            print("Image uploaded successfully")
            print("document ID Storage is \(documentId)")
        }
        
    }
    
    func getEntries(for userId: String, completion: @escaping ([Entry]?, Error?) -> ())  {
        let entriesRef = database.collection("entries")
        var entries = [Entry]()
        
        entriesRef.whereField("userId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    
                    if let userId = data["userId"] as? String,
                       let date = data["date"] as? String,
                       let title = data["title"] as? String,
                       let content = data["content"] as? String {
                        // В этом примере Entry определяется с использованием опциональных свойств
                        let entry = Entry(userId: userId, date: date, title: title, content: content, images: nil)
                        entries.append(entry)
                    }
                }
                print("OKKKK")
                completion(entries, nil)
                
            }
           
        }
       
    }
    
}
