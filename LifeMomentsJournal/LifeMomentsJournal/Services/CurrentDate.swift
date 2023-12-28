//
//  CurrentDate.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 18/12/2023.
//

import Foundation

struct CurrentDate {
    var date: String = {
        let timestamp = Date().timeIntervalSince1970
        let date = Date(timeIntervalSince1970: timestamp)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let formattedDateString = dateFormatter.string(from: date)
        print("my date is - \(formattedDateString)")
        return formattedDateString
    }()
}
