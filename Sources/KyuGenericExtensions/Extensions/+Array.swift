//  swiftlint:disable:this file_name
//
//  +Array.swift
//  KyuGenericExtensions
//

import Foundation

// MARK: - Partitioning an Array
public extension Array {
	/// Safer get Element from index.
	subscript(safe index: Index) -> Element? {
		return (index >= 0 && index < count) ? self[index] : nil
	}
	
	/// Partitioning an Array.
	func chunked(into size: Int) -> [[Element]] {
		return stride(from: 0, to: count, by: size).map {
			Array(self[$0 ..< Swift.min($0 + size, count)])
		}
	}
}
