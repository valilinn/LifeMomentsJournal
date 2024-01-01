//
//  Quote.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 01/01/2024.
//

import Foundation

struct Quote: Codable {
    let quoteText: String
    let quoteAuthor: String

    enum CodingKeys: String, CodingKey {
        case quoteText = "quoteText"
        case quoteAuthor = "quoteAuthor"
    }
}


