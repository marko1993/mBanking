//
//  String+Extensions.swift
//  mBanking
//
//  Created by Marko Matijević on 26.03.2022..
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM.yyyy."
        return dateFormatter.date(from: self)
    }
    
    func toDateWithoutDays() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM.yyyy."
        return dateFormatter.date(from: self)
    }
}
