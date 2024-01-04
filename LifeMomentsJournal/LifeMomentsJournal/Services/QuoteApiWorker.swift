//
//  QuoteApiWorker.swift
//  LifeMomentsJournal
//
//  Created by Валентина Лінчук on 01/01/2024.
//

import Foundation
import Alamofire

class QuoteApiWorker {
    static let baseUrl = "https://api.forismatic.com/api/1.0/"

    func getQuote(_ completion: @escaping ((Quote?) -> Void)) {
        var parameters: [String: Any] = [
            "method": "getQuote",
            "format": "json",
            "key": 457653,
            "lang": "en"
        ]


        AF.request(QuoteApiWorker.baseUrl, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: Quote.self) { response in
                switch response.result {
                case .success(let quote):
                    completion(quote)
                case .failure(let error):
                    completion(nil)
                    print("Api error is \(error)")
                }
            }
    }
}
