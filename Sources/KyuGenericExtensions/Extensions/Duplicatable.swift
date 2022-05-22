//
//  Duplicatable.swift
//  KyuGenericExtensions
//

import Foundation

public protocol Duplicatable: Codable {
	func duplicate() throws -> Self
}

public extension Duplicatable {
	func duplicate() throws -> Self {
		let data = try JSONEncoder().encode(self)
		let copy = try JSONDecoder().decode(Self.self, from: data)
		return copy
	}
}
