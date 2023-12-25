//
//  Entry.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/11/2023.
//

import Foundation

struct Entry: Identifiable, Codable {
    let id: String = UUID().uuidString
    let userId: String
    let date: String
    let title: String?
    let content: String?
    let images: [Data]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId  = "userId"
        case date = "date"
        case title = "title"
        case content = "content"
        case images = "images"
    }
}
