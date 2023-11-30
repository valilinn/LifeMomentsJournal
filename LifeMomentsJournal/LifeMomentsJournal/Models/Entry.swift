//
//  Entry.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 30/11/2023.
//

import Foundation

struct Entry: Identifiable {
    let id: String = UUID().uuidString
    let date: String
    let title: String
    let content: String
    let image: String
    
    static func getMockData() -> [Entry] {
        let mockData: [Entry] = [
            .init(date: "30.11.2023", title: "Morskie oko", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "morskieOko"),
            .init(date: "28.11.2023", title: "Zakopane", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "morskieOko"),
        ]
        return mockData
    }
}
