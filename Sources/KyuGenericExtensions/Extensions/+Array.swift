//  swiftlint:disable:this file_name
//
//  +Array.swift
//  KyuGenericExtensions
//

import Foundation

// MARK: - Partitioning an Array
public extension Array {
	/// Safer get an element from the current array at specified index.
	///
	/// - Parameters:
	/// 	- index: The index of an element.
	///
	/// - Returns: An element at specify index. `nil` if that element is not exists.
	///
	subscript(safe index: Index) -> Element? {
		(index >= 0 && index < count) ? self[index] : nil
	}
	
	/// Partitioning the current array into multiple chunks.
	///
	/// - Parameters:
	/// 	- size: Target size of the chunk.
	/// 	
	/// - Returns: Partitioned arrays of specifed size.
	///
	func chunked(into size: Int) -> [[Element]] {
		stride(from: 0, to: count, by: size).map { strideable in
			Array(self[strideable ..< Swift.min(strideable + size, count)])
		}
	}
}
