//
//  Diffable.swift
//  KyuGenericExtensions
//

import Foundation

public protocol Diffable: Hashable, Equatable {}
public extension Diffable {
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
	
	func hash(into hasher: inout Hasher) {
		let mirror = Mirror(reflecting: self)
		for child in mirror.children {
			if let value = child.value as? (any Hashable) {
				hasher.combine(value)
			}
		}
	}
}
