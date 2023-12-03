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
            .init(date: "MON 12", title: "Morskie oko", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "morskieOko"),
            .init(date: "TUE 13", title: "Zakopane Z Zakop Zakopane", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "study"),
            .init(date: "WED 14", title: "Pszczyna", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "morskieOko"),
            .init(date: "THU 15", title: "Szczyrk", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "morskieOko"),
            .init(date: "FRI 16", title: "Morskie oko", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "morskieOko"),
            .init(date: "SAT 17", title: "Zakopane", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "study"),
            .init(date: "SUN 18", title: "Pszczyna", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.", image: "morskieOko")
        ]
        return mockData
    }
}
