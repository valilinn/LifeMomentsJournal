//
//  Entry.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/11/2023.
//

import Foundation

struct Entry {
    var userId: String
    var documentId: String?
    var date: String
    var title: String?
    var content: String?
    var imagesData: [Data]?
    var imagesURL: [String]?
}
