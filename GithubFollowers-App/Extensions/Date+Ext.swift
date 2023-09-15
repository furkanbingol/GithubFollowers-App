//
//  Date+Ext.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 7.09.2023.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        
        return dateFormatter.string(from: self)
    }
    
    func convertToMonthYearFormat_New() -> String {
        return formatted(.dateTime.month().year())         // Equals: "MMM yyyy"
    }
}
