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
        
        var imagesURLArray: [String] = []
        
        if let imagesEnumerated = entry.imagesData?.enumerated() {
            let group = DispatchGroup()
            
            for (index, image) in imagesEnumerated {
                group.enter()
                saveImages(index: index, image: image, documentId: documentId) { url in
                    if let imageURL = url {
                        imagesURLArray.append(imageURL.absoluteString)
                    } else {
                        print("No images")
                    }
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                newDocumentRef.setData([
                    "userId": entry.userId,
                    "documentId": documentId,
                    "date": entry.date,
                    "title": entry.title ?? "",
                    "content": entry.content ?? "",
                    "imagesURL": imagesURLArray
                ]) { error in
                    if let error = error {
                        print("Error addimg document \(error)")
                    } else {
                        print("Document added successfully")
                    }
                    print("document ID Firestore is \(documentId)")
                }
            }
        }
    }
    
    private func saveImages(index: Int, image: Data, documentId: String, completion: @escaping (URL?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("images/\(documentId)")
        let imageRef = storageRef.child("image_\(index).jpg")
        
        imageRef.putData(image, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                print("Error uploading image: \(error.debugDescription)")
                return
            }
            imageRef.downloadURL { url, error in
                guard let downloadUrl = url else {
                    print("Downloaded URL not found")
                    completion(nil)
                    return
                }
                completion(downloadUrl)
                print("Image uploaded successfully")
                print("document ID Storage is \(documentId)")
            }
        }
    }
    
    
    func listenForEntries(for userId: String, completion: @escaping ([Entry]?, Error?) -> ())  {
        let entriesRef = database.collection("entries")
        var entries = [Entry]()
        
        entriesRef.whereField("userId", isEqualTo: userId).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else {
                print("Snapshot changes count: \(snapshot?.documentChanges.count ?? 0)")
                for change in snapshot!.documentChanges {
                    print("Change type: \(change.type.rawValue)")
                    let document = change.document
                    let data = document.data()
                    
                    if let userId = data["userId"] as? String,
                       let _ = data["documentId"] as? String,
                       let date = data["date"] as? String,
                       let title = data["title"] as? String,
                       let content = data["content"] as? String,
                       let imagesURL = data["imagesURL"] as? [String] {
                        let documentId = document.documentID
                        let entry = Entry(userId: userId, documentId: documentId, date: date, title: title, content: content, imagesData: nil, imagesURL: imagesURL)
                        entries.append(entry)
//                        completion(entries, nil)
                    }
                }
                completion(entries, nil)
            }
        }
    }
    
    func deleteEntry(documentId: String, completion: @escaping (Bool, Error?) -> ()) {
        let entriesRef = database.collection("entries").document(documentId)
        entriesRef.delete { [weak self] error in
            if let error = error {
                print("Error deleting document \(error)")
                completion(false, error)
            } else {
                self?.deleteFilesFromStorage(documentId: documentId) { storageError in
                    if let storageError = storageError {
                        print("Error when deleting files from Storage: \(storageError)")
                        completion(false, storageError)
                    } else {
                        print("Document deleted from Storage")
                        completion(true, nil)
                    }
                }
            }
        }
    }
    
    private func deleteFilesFromStorage(documentId: String, completion: @escaping (Error?) -> ()) {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("images/\(documentId)")
        
        // Delete all files
        storageRef.listAll { result, error in
            if let error = error {
                print("Error when listing files in storage: \(error)")
                completion(error)
            } else {
                let group = DispatchGroup()
                
                guard let items = result?.items else { return }
                
                for item in items {
                    group.enter()
                    item.delete { error in
                        if let error = error {
                            print("Error when deleting a file from Storage: \(error)")
                        }
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(nil)
                }
            }
        }
    }
    
    func updateEntry(entry: Entry) {
        guard let documentId = entry.documentId else { return }

        var updateData: [String: Any] = [
            "title": entry.title ?? "",
            "content": entry.content ?? ""
        ]

        if let imagesData = entry.imagesData, !imagesData.isEmpty {
            var imagesURLArray: [String] = []
            let group = DispatchGroup()

            for (index, image) in imagesData.enumerated() {
                group.enter()
                saveImages(index: index, image: image, documentId: documentId) { url in
                    if let imageURL = url {
                        imagesURLArray.append(imageURL.absoluteString)
                    } else {
                        print("No images")
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                updateData["imagesURL"] = imagesURLArray

                self.database.collection("entries").document(documentId).updateData(updateData) { error in
                    if let error = error {
                        print("Error updating document \(documentId): \(error)")
                    } else {
                        print("Document updated successfully")
                    }
                }
            }
        } else {
            // Handle the case when there are no images
            updateData["imagesURL"] = []
            self.database.collection("entries").document(documentId).updateData(updateData) { error in
                if let error = error {
                    print("Error updating document \(documentId): \(error)")
                } else {
                    print("Document updated successfully")
                }
            }
        }
    }
    
}
