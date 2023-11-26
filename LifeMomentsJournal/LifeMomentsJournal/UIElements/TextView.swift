//
//  TextView.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 26/11/2023.
//

import Foundation
import UIKit

struct TextView {
    func textLabel(text: String, fontSize: CGFloat = 16, weight: UIFont.Weight = .regular, color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = color
        return label
    }
}
