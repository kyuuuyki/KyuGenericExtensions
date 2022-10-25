//  swiftlint:disable:this file_name
//
//  +Int.swift
//  KyuGenericExtensions
//

import Foundation

public extension Int {
	func abbreviated(decimalPoints: Int) -> String {
		let units = ["", "K", "M", "B", "T", "P", "E"]
		var value = Double(self)
		for unit in units {
			if value < 1000 {
				return String(format: "%.\(decimalPoints)f%@", value, unit)
			}
			value /= 1000
		}
		return "\(value)"
	}
}
