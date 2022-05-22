//  swiftlint:disable:this file_name
//
//  +Date.swift
//  KyuGenericExtensions
//

import Foundation

// MARK: - Date from String
public extension Date {
	/// Get Date from String with configurable dateFormats.
	init?(
		string: String,
		format: String...,
		calendar: Calendar = Calendar(identifier: .gregorian),
		timeZone: TimeZone = TimeZone(identifier: "UTC")!
	) {
		let formatter = DateFormatter()
		formatter.calendar = calendar
		formatter.timeZone = timeZone
		
		for eachFormat in format {
			formatter.dateFormat = eachFormat
			if let date = formatter.date(from: string) {
				self = date
				return
			}
		}
		
		return nil
	}
}
