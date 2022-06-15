//  swiftlint:disable:this file_name
//
//  +Array.swift
//  KyuGenericExtensions
//

import Foundation

// MARK: - Partitioning an Array
public extension Array {
	/**
	 Safer get an element from the current array at specified index.
	 - parameter index: The index of an element.
	 - returns: An element at specify index. `Nil` if that element is not exists.
	 */
	subscript(safe index: Index) -> Element? {
		return (index >= 0 && index < count) ? self[index] : nil
	}
	
	/**
	 Partitioning the current array into multiple chunks.
	 - Parameter size: Target size of the chunk.
	 - Returns: Partitioned arrays of specifed size.
	 */
	func chunked(into size: Int) -> [[Element]] {
		return stride(from: 0, to: count, by: size).map {
			Array(self[$0 ..< Swift.min($0 + size, count)])
		}
	}
}
