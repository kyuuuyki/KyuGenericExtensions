//  swiftlint:disable:this file_name
//
//  +Date.swift
//  KyuGenericExtensions
//

//  swiftlint:disable line_length

import Foundation

// MARK: - Date from String
public extension Date {
	/// Returns a date representation of a specified string.
	/// - Parameters:
	/// 	- date: The string to format.
	/// 	- format: The date format for represented string.
	/// 	- calendar: The calendar for represented string. If unspecified, the logical calendar for the current user is used.
	/// 	- timeZone: The timezone for represented string. If unspecified, the system time zone is used.
	///
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
