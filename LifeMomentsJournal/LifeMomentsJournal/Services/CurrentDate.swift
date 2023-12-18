//
//  CurrentDate.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 18/12/2023.
//

import Foundation

struct CurrentDate {
    var date: String = {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let formattedDate = dateFormatter.string(from: currentDate)
        print(formattedDate)
        return formattedDate
    }()
}
