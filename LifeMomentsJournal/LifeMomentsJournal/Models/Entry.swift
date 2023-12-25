//
//  Entry.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/11/2023.
//

import Foundation

struct Entry: Identifiable {
    let id: String = UUID().uuidString
    let userId: String
    let date: String
    let title: String?
    let content: String?
    let images: [String]? = nil
    
}
