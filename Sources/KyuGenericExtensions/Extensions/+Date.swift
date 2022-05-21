//
//  +Date.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation

// MARK: - Date to String
extension Date {
    
    ///Get UTC TimeString from Date. Default format: '1969-07-21T02:56:15Z'.
    public func toUTCString(format: String) -> String {
        return toString(format: format, locale: Locale(identifier: "en_US_POSIX"), calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(abbreviation: "UTC")!)
    }
    
    ///Get TimeString from Date. Default format: '1969-07-21T02:56:15Z'.
    public func toString(format: String, locale: Locale, calendar: Calendar, timeZone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        
        return formatter.string(from: self)
    }
}
